#import "UntitledPlugin.h"
#if __has_include(<untitled/untitled-Swift.h>)
#import <untitled/untitled-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "untitled-Swift.h"
#endif

@implementation UntitledPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftUntitledPlugin registerWithRegistrar:registrar];
}
@end
