#include <napi.h>
#include <clingo.h>
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
    std::cerr << "on_model called" << std::endl;
    if (!model || !data || !goon) {
        std::cerr << "Invalid parameters in on_model" << std::endl;
        return false;
    }
    
    std::vector<std::string>* answers = static_cast<std::vector<std::string>*>(data);
    
    clingo_symbol_t *atoms = nullptr;
    size_t atoms_size;
    
    // Get the size of the model
    if (!clingo_model_symbols_size(model, clingo_show_type_shown, &atoms_size)) {
        std::cerr << "Failed to get model symbols size" << std::endl;
        return false;
    }
    
    std::cerr << "Model size: " << atoms_size << std::endl;
    
    if (atoms_size == 0) {
        answers->push_back("");
        *goon = true;
        return true;
    }
    
    // Allocate space for the atoms
    try {
        atoms = new clingo_symbol_t[atoms_size];
    } catch (const std::bad_alloc&) {
        std::cerr << "Failed to allocate memory for atoms" << std::endl;
        return false;
    }
    
    // Get the model symbols
    if (!clingo_model_symbols(model, clingo_show_type_shown, atoms, atoms_size)) {
        std::cerr << "Failed to get model symbols" << std::endl;
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
            std::cerr << "Failed to get symbol string size" << std::endl;
            success = false;
            break;
        }
        
        // Allocate space for the string
        try {
            str = new char[str_size];
        } catch (const std::bad_alloc&) {
            std::cerr << "Failed to allocate memory for symbol string" << std::endl;
            success = false;
            break;
        }
        
        // Get the string representation
        if (!clingo_symbol_to_string(atoms[i], str, str_size)) {
            std::cerr << "Failed to convert symbol to string" << std::endl;
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
            std::cerr << "Failed to store answer" << std::endl;
            success = false;
        }
    }
    
    delete[] atoms;
    *goon = success;
    return success;
}

// Wrapper for the solve event callback
bool solve_event_callback(uint32_t type, void* event, void* data, bool* goon) {
    std::cerr << "solve_event_callback called with type: " << type << std::endl;
    if (!event || !data || !goon) {
        std::cerr << "Invalid parameters in solve_event_callback" << std::endl;
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
        std::cerr << "Solve function called" << std::endl;
        
        // Check arguments
        if (info.Length() < 1 || !info[0].IsString()) {
            throw Napi::TypeError::New(env, "String argument expected for program");
        }

        std::string program = info[0].As<Napi::String>().Utf8Value();
        std::cerr << "Program size: " << program.size() << " bytes" << std::endl;
        
        std::cerr << "Creating control object..." << std::endl;
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
        
        std::cerr << "Adding program..." << std::endl;
        // Add the program
        if (!clingo_control_add(ctl, "base", nullptr, 0, program.c_str())) {
            HandleClingoError(env);
        }
        
        std::cerr << "Grounding program..." << std::endl;
        // Ground the program
        clingo_part_t parts[] = {{ "base", nullptr, 0 }};
        if (!clingo_control_ground(ctl, parts, 1, nullptr, nullptr)) {
            HandleClingoError(env);
        }
        
        std::cerr << "Starting solve..." << std::endl;
        // Solve the program
        std::vector<std::string> answers;
        clingo_solve_handle_t *handle = nullptr;
        
        // Use clingo_solve_mode_yield to get all answer sets
        if (!clingo_control_solve(ctl, clingo_solve_mode_yield, nullptr, 0, solve_event_callback, &answers, &handle)) {
            HandleClingoError(env);
        }
        
        if (!handle) {
            throw Napi::Error::New(env, "Failed to create solve handle");
        }
        
        std::unique_ptr<clingo_solve_handle_t, void(*)(clingo_solve_handle_t*)> handle_guard(
            handle, 
            [](clingo_solve_handle_t* h) { 
                if (h) {
                    std::cerr << "Closing solve handle..." << std::endl;
                    clingo_solve_handle_close(h); 
                }
            }
        );
        
        std::cerr << "Getting solve result..." << std::endl;
        // Wait for solving to finish
        clingo_solve_result_bitset_t result;
        if (!clingo_solve_handle_get(handle, &result)) {
            HandleClingoError(env);
        }
        
        auto end = std::chrono::high_resolution_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end - start);
        
        std::cerr << "Creating result object..." << std::endl;
        // Create result object with answers and execution time
        Napi::Object resultObj = Napi::Object::New(env);
        
        Napi::Array answersArray = Napi::Array::New(env, answers.size());
        for (size_t i = 0; i < answers.size(); ++i) {
            answersArray[i] = Napi::String::New(env, answers[i]);
        }
        
        resultObj.Set("answers", answersArray);
        resultObj.Set("executionTime", Napi::Number::New(env, duration.count()));
        
        std::cerr << "Solve completed successfully" << std::endl;
        return resultObj;
        
    } catch (const std::exception& e) {
        std::cerr << "C++ exception: " << e.what() << std::endl;
        throw Napi::Error::New(env, e.what());
    } catch (...) {
        std::cerr << "Unknown C++ exception" << std::endl;
        throw Napi::Error::New(env, "Unknown error occurred");
    }
}

Napi::Object Init(Napi::Env env, Napi::Object exports) {
    exports.Set(
        Napi::String::New(env, "solve"),
        Napi::Function::New(env, Solve)
    );
    return exports;
}

NODE_API_MODULE(node_clingo, Init) 