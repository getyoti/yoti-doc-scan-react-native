#import <React/RCTBridgeModule.h>
#import <UIKit/UIKit.h>
#import <YotiSDKCore/YotiSDKCore-Swift.h>

@interface RNYotiDocScan: NSObject<RCTBridgeModule, UINavigationControllerDelegate, YotiSDKDataSource, YotiSDKDelegate>

@end
