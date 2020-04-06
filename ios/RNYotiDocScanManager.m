#import "RNYotiDocScanManager.h"
#import <React/RCTUtils.h>
#import "ZoomPublicApi.h"
#import "YotiSDKCommon-Swift.h"
#import "YotiSDKCore-Swift.h"
#import "YotiSDKDocument-Swift.h"
#import "YotiSDKZoom-Swift.h"

NSInteger const kYotiSuccessStatusCode = 0;

@interface RNYotiDocScanManager ()

@property (nonatomic, strong) YotiSDKNavigationController *yotiSDKNavigationController;
@property (nonatomic, strong) UIViewController *rootViewController;
@property (nonatomic, strong) NSString *sessionID;
@property (nonatomic, strong) NSString *sessionToken;
@property (nonatomic, strong) RCTResponseSenderBlock errorCallback;
@property (nonatomic, strong) RCTResponseSenderBlock successCallback;
@end

@implementation RNYotiDocScanManager

RCT_EXPORT_MODULE(RNYotiDocScan);

RCT_EXPORT_METHOD(startSession:(NSString *)sessionId clientSessionToken:(NSString *)clientSessionToken successCallback:(RCTResponseSenderBlock)successCallback errorCallback:(RCTResponseSenderBlock)errorCallback)
{
    self.sessionID = sessionId;
    self.sessionToken = clientSessionToken;
    self.errorCallback = errorCallback;
    self.successCallback = successCallback;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.yotiSDKNavigationController = [[YotiSDKNavigationController alloc] init];
        self.yotiSDKNavigationController.sdkDataSource = self;
        self.yotiSDKNavigationController.sdkDelegate = self;
        self.rootViewController = RCTPresentedViewController();
        [self.rootViewController presentViewController:self.yotiSDKNavigationController animated:YES completion:nil];
    });
    
}

// MARK: - Data source delegate

- (NSArray<Class<YotiSDKModule>> * _Nonnull)supportedModuleTypesFor:(YotiSDKNavigationController * _Nonnull)navigationController {
    return @[[YotiSDKDocument class], [YotiSDKZoom class]];
}

- (NSString * _Nonnull)sessionIDFor:(YotiSDKNavigationController * _Nonnull)navigationController {
    return self.sessionID;
}

- (NSString * _Nonnull)sessionTokenFor:(YotiSDKNavigationController * _Nonnull)navigationController {
    return self.sessionToken;
}

- (UIColor * _Nonnull)primaryColorFor:(YotiSDKNavigationController * _Nonnull)navigationController {
    return [UIColor colorWithRed:34.0/255.0 green:157.0/255.0 blue:255.0/255.0 alpha:1.0];
}

// MARK: - SDK Delegate

- (void)navigationController:(YotiSDKNavigationController * _Nonnull)navigationController didFinishWithStatusCode:(NSInteger)statusCode {
    [self.rootViewController dismissViewControllerAnimated:YES completion:nil];
    if (statusCode == kYotiSuccessStatusCode) {
        self.successCallback(@[[NSNumber numberWithLong:statusCode]]);
        return;
    }
    self.errorCallback(@[[NSNumber numberWithLong:statusCode]]);
}

@end
