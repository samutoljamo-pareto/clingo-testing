{
  "targets": [
    {
      "target_name": "node-clingo",
      "cflags!": [ "-fno-exceptions" ],
      "cflags_cc!": [ "-fno-exceptions" ],
      "sources": [ 
        "src/binding.cc"
      ],
      "include_dirs": [
        "<!@(node -p \"require('node-addon-api').include\")",
        "C:/Users/Samu T/AppData/Roaming/Python/Python313/site-packages/clingo"
      ],
      "defines": [ 
        "NAPI_DISABLE_CPP_EXCEPTIONS",
        "WITH_THREADS=1",
        "CLINGO_WITH_PYTHON=0"
      ],
      "conditions": [
        ['OS=="win"', {
          "msvs_settings": {
            "VCCLCompilerTool": {
              "ExceptionHandling": 1,
              "AdditionalOptions": ["/EHsc"]
            }
          },
          "libraries": [
            "import__clingo.lib"
          ],
          "library_dirs": [
            "C:/Users/Samu T/AppData/Roaming/Python/Python313/site-packages/clingo"
          ],
          "copies": [{
            "destination": "build/Release",
            "files": [
              "C:/Users/Samu T/AppData/Roaming/Python/Python313/site-packages/clingo/_clingo.cp313-win_amd64.pyd"
            ]
          }]
        }],
        ['OS!="win"', {
          "libraries": [
            "-lclingo"
          ],
          "library_dirs": [
            "<!@(python -c \"import clingo; print(os.path.dirname(clingo.__file__))\")"
          ]
        }]
      ]
    }
  ]
}