{
  "targets": [
    {
      "target_name": "node-clingo",
      "sources": [
        "src/binding.cc"
      ], 
      "include_dirs": [
        "<!@(node -p \"require('node-addon-api').include\")",
        "<(module_root_dir)/clingo-source/libclingo",
        "<(module_root_dir)/clingo-source/libpyclingo"
      ],
      "defines": [
        "NAPI_DISABLE_CPP_EXCEPTIONS",
        "WITH_THREADS=1",
        "CLINGO_WITH_PYTHON=1"
       #"CLINGO_WITH_PYTHON=0"
      ],
      "libraries": [
        "<(module_root_dir)/clingo-source/build/lib/Release/import_clingo.lib",
        "<(module_root_dir)/clingo-source/build/lib/Release/pyclingo.lib",
        "<!@(python -c \"import sys; print(sys.prefix)\")/libs/python311.lib"
      ],



      "library_dirs": [
        "<(module_root_dir)/clingo-source/build/lib/Release",
      ],
      "conditions": [
        [ "OS=='win'", {
          "msvs_settings": {
            "VCCLCompilerTool": {
              "ExceptionHandling": 1,
              "AdditionalOptions": [ "/EHsc" ]
            }
          }
        }]
      ]
    }
  ]
}
