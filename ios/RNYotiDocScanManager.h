#import <React/RCTBridgeModule.h>
#import <UIKit/UIKit.h>

#import "YotiSDKCore-Swift.h"

@interface RNYotiDocScanManager : NSObject <RCTBridgeModule, UINavigationControllerDelegate, YotiSDKDataSource, YotiSDKDelegate>

@end
