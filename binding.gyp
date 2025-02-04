{
  "targets": [
    {
      "target_name": "node-clingo",
      "cflags!": [ "-fno-exceptions" ],
      "cflags_cc!": [ "-fno-exceptions" ],
      "sources": [ "src/binding.cc" ],
      "include_dirs": [
        "<!@(node -p \"require('node-addon-api').include\")",
        "<!@(python -c \"import clingo; import os; print(os.path.dirname(clingo.__file__).replace('\\\\', '/'))\")"
      ],
      "conditions": [
        ['OS=="win"', {
          "library_dirs": [
            "<!@(python -c \"import clingo; import os; print(os.path.dirname(clingo.__file__).replace('\\\\', '/'))\")"
          ],
          "libraries": [
            "clingo"
          ],
          "msvs_settings": {
            "VCCLCompilerTool": {
              "AdditionalIncludeDirectories": [
                "<!@(python -c \"import clingo; import os; print(os.path.dirname(clingo.__file__).replace('\\\\', '/'))\")"
              ]
            }
          }
        }],
        ['OS!="win"', {
          "library_dirs": [
            "<!@(python -c \"import clingo; import os; print(os.path.dirname(clingo.__file__))\")"
          ],
          "libraries": [
            "-lclingo"
          ]
        }]
      ],
      "defines": [ "NAPI_DISABLE_CPP_EXCEPTIONS" ]
    }
  ]
}