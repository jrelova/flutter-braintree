#import "FlutterBraintreePlugin.h"
#import <braintree_flutter_plus/braintree_flutter_plus-Swift.h>

@implementation FlutterBraintreePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    [FlutterBraintreeCustomPlugin registerWithRegistrar:registrar];
    [FlutterBraintreeDropInPlugin registerWithRegistrar:registrar];
}
@end
