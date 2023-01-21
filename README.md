# A minimal example of how to link and call [assimp](https://github.com/assimp/assimp) from Swift

This sample does not show how to draw or otherwise manipulate loaded assets. Its sole purpose is to show how to configure a macOS app target to use assimp.

This repository includes assimp as a submodule. To use it, you will either need to clone it recursively or download assimp separately and move it into this directory.

If you run into issues with linking minizip, you may need to apply [this fix](https://stackoverflow.com/a/54103956/155187) to CMakeLists.txt in the assimp directory (insert the relevant patch above [line 167](https://github.com/assimp/assimp/blob/9e1de3ec6e6a5749ff23f3b8640da96bb32b1046/CMakeLists.txt#L167).

You should then be able to build assimp in the ordinary way (using `cmake`) to produce a dynamic library (.dylib). The included Xcode project assumes an assimp version of [5.2.5](https://github.com/assimp/assimp/releases/tag/v5.2.5).

Since Xcode insists on following aliases when adding libraries to be embedded and linked, the "shared library id name" written into the dylib (`@rpath/libassimp.5.dylib`) is incorrect in the final app target. For this reason, a small script is run during compilation to adjust the id name to match the name of the actually embedded dylib (`@rpath/libassimp.5.2.5.dylib` in this case).

The header and library search paths should also be updated to include `$(SRCROOT)/../assimp/include` and `$(SRCROOT)/../assimp/bin` respectively.

To actually use assimp from Swift, it is necessary to use a bridging header to include the relevant headers (e.g. `<assimp/cimport.h>`). Then, the types and functions in assimp are available for use via a generated Swift interface.
