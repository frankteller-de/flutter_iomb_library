#import "FlutterIombLibraryPlugin.h"
#if __has_include(<flutter_iomb_library/flutter_iomb_library-Swift.h>)
#import <flutter_iomb_library/flutter_iomb_library-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_iomb_library-Swift.h"
#endif

@implementation FlutterIombLibraryPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterIombLibraryPlugin registerWithRegistrar:registrar];
}
@end
