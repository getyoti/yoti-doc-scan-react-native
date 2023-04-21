#import "RNYotiDocScanManager.h"
#import <React/RCTUtils.h>
#import <FaceTecSDK/FaceTecPublicApi.h>
#import <YotiSDKNetwork/YotiSDKNetwork-Swift.h>
#import <YotiSDKCommon/YotiSDKCommon-Swift.h>
#import <YotiSDKCore/YotiSDKCore-Swift.h>
#import <YotiSDKDocument/YotiSDKDocument-Swift.h>
#import <YotiSDKFaceTec/YotiSDKFaceTec-Swift.h>

NSInteger const kYotiSuccessStatusCode = 0;

@interface RNYotiDocScanManager ()

@property (nonatomic, strong) YotiSDKNavigationController *yotiSDKNavigationController;
@property (nonatomic, strong) UIViewController *rootViewController;
@property (nonatomic, strong) NSString *sessionID;
@property (nonatomic, strong) NSString *sessionToken;
@property (nonatomic, assign) BOOL setUpCanadaServerLocation;
@property (nonatomic, strong) UIColor *primaryColor;
@property (nonatomic, strong) RCTResponseSenderBlock errorCallback;
@property (nonatomic, strong) RCTResponseSenderBlock successCallback;
@end

@implementation RNYotiDocScanManager

RCT_EXPORT_MODULE(RNYotiDocScan);

RCT_EXPORT_METHOD(useCanadaService) {
    self.setUpCanadaServerLocation = YES;
}

RCT_EXPORT_METHOD(setPrimaryColorRGB:(double)red green:(double)green blue:(double)blue) {
    self.primaryColor = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}

RCT_EXPORT_METHOD(setRequestCode:(NSNumber * _Nonnull)requestCode) {
    // Required to maintain cross-platform API compatibility.
}

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

RCT_EXPORT_METHOD(closeSession:(BOOL)animated completionCallback:(RCTResponseSenderBlock)completionCallback) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.rootViewController dismissViewControllerAnimated:animated completion:^{
            if (completionCallback) {
                completionCallback(nil);
            }
        }];
    });
}

// MARK: - Data source delegate

- (NSArray<Class<YotiSDKModule>> * _Nonnull)supportedModuleTypesFor:(YotiSDKNavigationController * _Nonnull)navigationController {
    return @[[YotiSDKDocumentModule class], [YotiSDKFaceTecModule class]];
}

- (NSString * _Nonnull)sessionIDFor:(YotiSDKNavigationController * _Nonnull)navigationController {
    return self.sessionID;
}

- (NSString * _Nonnull)sessionTokenFor:(YotiSDKNavigationController * _Nonnull)navigationController {
    return self.sessionToken;
}

- (ServerLocation)serverLocationFor:(YotiSDKNavigationController * _Nonnull)navigationController {
    if (self.setUpCanadaServerLocation) {
        return ServerLocationCanada;
    } else {
        return ServerLocationUnitedKingdom;
    }
}

- (BOOL)isReactNativeClientFor:(YotiSDKNavigationController * _Nonnull)navigationController {
    return YES;
}

// MARK: - SDK Delegate

- (UIColor * _Nonnull)primaryColorFor:(YotiSDKNavigationController * _Nonnull)navigationController {
    if (self.primaryColor != nil) {
        return self.primaryColor;
    } else {
        return [UIColor colorWithRed:34.0/255.0 green:157.0/255.0 blue:255.0/255.0 alpha:1.0];
    }
}

- (void)navigationController:(YotiSDKNavigationController * _Nonnull)navigationController didFinishWithStatusCode:(NSInteger)statusCode {
    [self.rootViewController dismissViewControllerAnimated:YES completion:nil];
    if (statusCode == kYotiSuccessStatusCode) {
        self.successCallback(@[[NSNumber numberWithLong:statusCode]]);
        return;
    }
    self.errorCallback(@[[NSNumber numberWithLong:statusCode]]);
}

@end
