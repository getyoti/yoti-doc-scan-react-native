#import "RNYotiDocScan.h"
#import <React/RCTUtils.h>
#import <YotiSDKNetwork/YotiSDKNetwork-Swift.h>
#import <YotiSDKCommon/YotiSDKCommon-Swift.h>
#import <YotiSDKCore/YotiSDKCore-Swift.h>
#if __has_include(<YotiSDKIdentityDocument/YotiSDKIdentityDocument-Swift.h>)
#import <YotiSDKIdentityDocument/YotiSDKIdentityDocument-Swift.h>
#endif
#if __has_include(<YotiSDKSupplementaryDocument/YotiSDKSupplementaryDocument-Swift.h>)
#import <YotiSDKSupplementaryDocument/YotiSDKSupplementaryDocument-Swift.h>
#endif
#if __has_include(<YotiSDKFaceTec/YotiSDKFaceTec-Swift.h>)
#import <YotiSDKFaceTec/YotiSDKFaceTec-Swift.h>
#endif
#if __has_include(<YotiSDKFaceCapture/YotiSDKFaceCapture-Swift.h>)
#import <YotiSDKFaceCapture/YotiSDKFaceCapture-Swift.h>
#endif

NSInteger const kYotiSuccessStatusCode = 0;

@interface RNYotiDocScan()

@property (nonatomic, strong) YotiSDKNavigationController *yotiSDKNavigationController;
@property (nonatomic, strong) UIViewController *rootViewController;
@property (nonatomic, strong) NSString *sessionID;
@property (nonatomic, strong) NSString *sessionToken;
@property (nonatomic, assign) BOOL setUpCanadaServerLocation;
@property (nonatomic, strong) UIColor *primaryColor;
@property (nonatomic, strong) RCTResponseSenderBlock errorCallback;
@property (nonatomic, strong) RCTResponseSenderBlock successCallback;
@end

@implementation RNYotiDocScan

RCT_EXPORT_MODULE(RNYotiDocScan);

RCT_EXPORT_METHOD(useCanadaService) {
    _setUpCanadaServerLocation = YES;
}

RCT_EXPORT_METHOD(setPrimaryColorRGB:(double)red green:(double)green blue:(double)blue) {
    _primaryColor = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}

RCT_EXPORT_METHOD(setRequestCode:(NSNumber * _Nonnull)requestCode) {
    // Required to maintain cross-platform API compatibility.
}

RCT_EXPORT_METHOD(startSession:(NSString *)sessionId clientSessionToken:(NSString *)clientSessionToken successCallback:(RCTResponseSenderBlock)successCallback errorCallback:(RCTResponseSenderBlock)errorCallback)
{
    _sessionID = sessionId;
    _sessionToken = clientSessionToken;
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

// MARK: - YotiSDKDataSource
- (NSArray<Class<YotiSDKModule>> * _Nonnull)supportedModuleTypesFor:(YotiSDKNavigationController * _Nonnull)navigationController {
    NSMutableArray *moduleTypes = [NSMutableArray array];
    #if __has_include(<YotiSDKIdentityDocument/YotiSDKIdentityDocument-Swift.h>)
    [moduleTypes addObject:[YotiSDKIdentityDocumentModule class]];
    #endif
    #if __has_include(<YotiSDKSupplementaryDocument/YotiSDKSupplementaryDocument-Swift.h>)
    [moduleTypes addObject:[YotiSDKSupplementaryDocumentModule class]];
    #endif
    #if __has_include(<YotiSDKFaceTec/YotiSDKFaceTec-Swift.h>)
    [moduleTypes addObject:[YotiSDKFaceTecModule class]];
    #endif
    #if __has_include(<YotiSDKFaceCapture/YotiSDKFaceCapture-Swift.h>)
    [moduleTypes addObject:[YotiSDKFaceCaptureModule class]];
    #endif
    return moduleTypes;
}

- (NSString * _Nonnull)sessionIDFor:(YotiSDKNavigationController * _Nonnull)navigationController {
    return _sessionID;
}

- (NSString * _Nonnull)sessionTokenFor:(YotiSDKNavigationController * _Nonnull)navigationController {
    return _sessionToken;
}

- (ServerLocation)serverLocationFor:(YotiSDKNavigationController * _Nonnull)navigationController {
    if (_setUpCanadaServerLocation) {
        return ServerLocationCanada;
    } else {
        return ServerLocationUnitedKingdom;
    }
}

- (BOOL)isReactNativeClientFor:(YotiSDKNavigationController * _Nonnull)navigationController {
    return YES;
}

// MARK: - YotiSDKDelegate
- (UIColor * _Nonnull)primaryColorFor:(YotiSDKNavigationController * _Nonnull)navigationController {
    if (_primaryColor != nil) {
        return _primaryColor;
    } else {
        return [UIColor colorWithRed:34.0/255.0 green:157.0/255.0 blue:255.0/255.0 alpha:1.0];
    }
}

- (void)navigationController:(YotiSDKNavigationController * _Nonnull)navigationController didFinishWithStatusCode:(NSInteger)statusCode {
    [_rootViewController dismissViewControllerAnimated:YES completion:nil];
    if (statusCode == kYotiSuccessStatusCode) {
        _successCallback(@[[NSNumber numberWithLong:statusCode]]);
        return;
    }
    _errorCallback(@[[NSNumber numberWithLong:statusCode]]);
}

@end
