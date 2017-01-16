# Explanation

This app demonstrates an issue when trying to use the `OLMKit` pod with the `use_frameworks!` setting.

The `use_frameworks!` setting is required in order for a Swift app to use the pods (it is not required for Obj-C development, however).

## Try this:

1. `pod install` - to install all dependencies (Note: 'OLMKit' is **not** included in the pod file)
2. Run the project (simulator is fine). The app pulls all the public rooms from https://matrix.org. (but encryption won't be supported... gross)
3. Comment out the `use_frameworks!` setting in the podfile. `pod install` again.
4. Attempt to build the project. **It fails!** (Swift errors out at the `import MatrixSDK` line, complaining that it can't find that module)
5. un-comment `use_frameworks!` (necessary for Swift), then un-comment `pod 'OLMKit'` (necessary for encryption) in the podfile. `pod install` once more.
6. Attempt to build and run the project. **It fails!** (see below)

## Error message

The compiler fails with a `Apple Mach-O Linker Error`. Here is the text:

    Ld /Users/averypierce/Library/Developer/Xcode/DerivedData/Dummy-Matrix-Client-Swift-hdglxcdleqidcaeerdmokndwkznq/Build/Products/Debug-iphonesimulator/OLMKit/OLMKit.framework/OLMKit normal x86_64
    cd /Users/averypierce/Projects/Junk/Dummy-Matrix-Client-Swift/Pods
    export IPHONEOS_DEPLOYMENT_TARGET=8.0
    export PATH="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/usr/bin:/Applications/Xcode.app/Contents/Developer/usr/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
    /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang++ -arch x86_64 -dynamiclib -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator10.2.sdk -L/Users/averypierce/Library/Developer/Xcode/DerivedData/Dummy-Matrix-Client-Swift-hdglxcdleqidcaeerdmokndwkznq/Build/Products/Debug-iphonesimulator/OLMKit -F/Users/averypierce/Library/Developer/Xcode/DerivedData/Dummy-Matrix-Client-Swift-hdglxcdleqidcaeerdmokndwkznq/Build/Products/Debug-iphonesimulator/OLMKit -filelist /Users/averypierce/Library/Developer/Xcode/DerivedData/Dummy-Matrix-Client-Swift-hdglxcdleqidcaeerdmokndwkznq/Build/Intermediates/Pods.build/Debug-iphonesimulator/OLMKit.build/Objects-normal/x86_64/OLMKit.LinkFileList -install_name @rpath/OLMKit.framework/OLMKit -Xlinker -rpath -Xlinker @executable_path/Frameworks -Xlinker -rpath -Xlinker @loader_path/Frameworks -mios-simulator-version-min=8.0 -dead_strip -Xlinker -object_path_lto -Xlinker /Users/averypierce/Library/Developer/Xcode/DerivedData/Dummy-Matrix-Client-Swift-hdglxcdleqidcaeerdmokndwkznq/Build/Intermediates/Pods.build/Debug-iphonesimulator/OLMKit.build/Objects-normal/x86_64/OLMKit_lto.o -Xlinker -export_dynamic -Xlinker -no_deduplicate -Xlinker -objc_abi_version -Xlinker 2 -stdlib=libc++ -fobjc-arc -fobjc-link-runtime -lc++ -framework Foundation -single_module -compatibility_version 1 -current_version 1 -Xlinker -dependency_info -Xlinker /Users/averypierce/Library/Developer/Xcode/DerivedData/Dummy-Matrix-Client-Swift-hdglxcdleqidcaeerdmokndwkznq/Build/Intermediates/Pods.build/Debug-iphonesimulator/OLMKit.build/Objects-normal/x86_64/OLMKit_dependency_info.dat -o /Users/averypierce/Library/Developer/Xcode/DerivedData/Dummy-Matrix-Client-Swift-hdglxcdleqidcaeerdmokndwkznq/Build/Products/Debug-iphonesimulator/OLMKit/OLMKit.framework/OLMKit

    duplicate symbol _OLMKitVersionString in:
        /Users/averypierce/Library/Developer/Xcode/DerivedData/Dummy-Matrix-Client-Swift-hdglxcdleqidcaeerdmokndwkznq/Build/Intermediates/Pods.build/Debug-iphonesimulator/OLMKit.build/Objects-normal/x86_64/OLMKit.o
        /Users/averypierce/Library/Developer/Xcode/DerivedData/Dummy-Matrix-Client-Swift-hdglxcdleqidcaeerdmokndwkznq/Build/Intermediates/Pods.build/Debug-iphonesimulator/OLMKit.build/Objects-normal/x86_64/OLMKit_vers.o
    ld: 1 duplicate symbol for architecture x86_64
    clang: error: linker command failed with exit code 1 (use -v to see invocation)
