    #include <napi.h>
    #include <clingo.h>
    #include <pyclingo.h>
    #include <string>
    #include <vector>
    #include <sstream>
    #include <chrono>
    #include <iostream>


    // Helper function to handle Clingo errors
    void HandleClingoError(const Napi::Env& env) {
        if (clingo_error_code() != 0) {
            std::cerr << "Clingo error: " << clingo_error_message() << std::endl;
            throw Napi::Error::New(env, clingo_error_message());
        }
    }

    // Callback for Clingo's ground function
    bool ground_callback(clingo_location_t const *location, char const *name, 
                        clingo_symbol_t const *arguments, size_t arguments_size, 
                        void *data, clingo_symbol_callback_t symbol_callback, 
                        void *symbol_callback_data) {
        return true;
    }

    // Callback for Clingo's solve function
    bool on_model(clingo_model_t const *model, void *data, bool *goon) {
        if (!model || !data || !goon) {
            return false;
        }
        
        std::vector<std::string>* answers = static_cast<std::vector<std::string>*>(data);
        
        clingo_symbol_t *atoms = nullptr;
        size_t atoms_size;
        
        // Get the size of the model
        if (!clingo_model_symbols_size(model, clingo_show_type_shown, &atoms_size)) {
            return false;
        }
        
        
        if (atoms_size == 0) {
            answers->push_back("");
            *goon = true;
            return true;
        }
        
        // Allocate space for the atoms
        try {
            atoms = new clingo_symbol_t[atoms_size];
        } catch (const std::bad_alloc&) {
            return false;
        }
        
        // Get the model symbols
        if (!clingo_model_symbols(model, clingo_show_type_shown, atoms, atoms_size)) {
            delete[] atoms;
            return false;
        }
        
        std::stringstream ss;
        bool success = true;
        
        // Convert each symbol to string
        for (size_t i = 0; i < atoms_size && success; ++i) {
            char *str = nullptr;
            size_t str_size;
            
            // Get the size needed for the string representation
            if (!clingo_symbol_to_string_size(atoms[i], &str_size)) {
                success = false;
                break;
            }
            
            // Allocate space for the string
            try {
                str = new char[str_size];
            } catch (const std::bad_alloc&) {
                success = false;
                break;
            }
            
            // Get the string representation
            if (!clingo_symbol_to_string(atoms[i], str, str_size)) {
                delete[] str;
                success = false;
                break;
            }
            
            if (i > 0) ss << std::endl;
            ss << str;
            delete[] str;

        }
        
        if (success) {
            try {
                answers->push_back(ss.str());
            } catch (const std::bad_alloc&) {
                success = false;
            }
        }
        
        delete[] atoms;
        *goon = success;
        return success;
    }

    // Wrapper for the solve event callback
    bool solve_event_callback(uint32_t type, void* event, void* data, bool* goon) {
        if (!event || !data || !goon) {
            return false;
        }
        
        if (type == clingo_solve_event_type_model) {
            return on_model(static_cast<const clingo_model_t*>(event), data, goon);
        }
        return true;
    }

    Napi::Value Solve(const Napi::CallbackInfo& info) {
        Napi::Env env = info.Env();
        
        try {
            
            // Check arguments
            if (info.Length() < 1 || !info[0].IsString()) {
                throw Napi::TypeError::New(env, "String argument expected for program");
            }

            std::string program = info[0].As<Napi::String>().Utf8Value();
            
            auto start = std::chrono::high_resolution_clock::now();
            
            // Create control object with no arguments
            clingo_control_t *ctl = nullptr;
            if (!clingo_control_new(nullptr, 0, nullptr, nullptr, 20, &ctl)) {
                HandleClingoError(env);
            }
            
            if (!ctl) {
                throw Napi::Error::New(env, "Failed to create control object");
            }
            
            std::unique_ptr<clingo_control_t, void(*)(clingo_control_t*)> ctl_guard(ctl, clingo_control_free);
            
            // Add the program
            if (!clingo_control_add(ctl, "base", nullptr, 0, program.c_str())) {
                HandleClingoError(env);
            }
            
            // Ground the program
            clingo_part_t parts[] = {{ "base", nullptr, 0 }};
            if (!clingo_control_ground(ctl, parts, 1, ground_callback, nullptr)) {
                HandleClingoError(env);
            }
            
            // Solve the program
            std::vector<std::string> answers;
            clingo_solve_handle_t *handle = nullptr;
            
            // Use clingo_solve_mode_yield to get all answer sets
            if (!clingo_control_solve(ctl, clingo_solve_mode_yield, nullptr, 0, solve_event_callback, &answers, &handle)){
                HandleClingoError(env);
            }
            
            if (!handle) {
                throw Napi::Error::New(env, "Failed to create solve handle");
            }
            
            std::unique_ptr<clingo_solve_handle_t, void(*)(clingo_solve_handle_t*)> handle_guard(
                handle, 
                [](clingo_solve_handle_t* h) { 
                    if (h) {
                        clingo_solve_handle_close(h); 
                    }
                }
            );
            
            // Wait for solving to finish
            clingo_solve_result_bitset_t result;
            if (!clingo_solve_handle_get(handle, &result)) {
                HandleClingoError(env);
            }
            
            auto end = std::chrono::high_resolution_clock::now();
            auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end - start);
            
            // Create result object with answers and execution time
            Napi::Object resultObj = Napi::Object::New(env);
            
            Napi::Array answersArray = Napi::Array::New(env, answers.size());
            for (size_t i = 0; i < answers.size(); ++i) {
                answersArray[i] = Napi::String::New(env, answers[i]);
            }
            
            resultObj.Set("answers", answersArray);
            resultObj.Set("executionTime", Napi::Number::New(env, duration.count()));
            
            return resultObj;
            
        } catch (const std::exception& e) {
            throw Napi::Error::New(env, e.what());
        } catch (...) {
            throw Napi::Error::New(env, "Unknown error occurred");
        }
    }

    Napi::Object Init(Napi::Env env, Napi::Object exports) {
        std::cerr << "Initializing Node.js module..." << std::endl;
        if (!clingo_register_python_()) {
            std::string error = clingo_error_message();
            std::cerr << "Failed to register Python: " << error << std::endl;
            throw Napi::Error::New(env, "Failed to register Python: " + error);
        }
        std::cerr << "Python integration successful" << std::endl;

        exports.Set(
            Napi::String::New(env, "solve"),
            Napi::Function::New(env, Solve)
        );


        return exports;
    }

    NODE_API_MODULE(node_clingo, Init) 