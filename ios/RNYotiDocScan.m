//
//  Copyright © 2025 Yoti Ltd. All rights reserved.
//

#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RNYotiDocScan, NSObject)

RCT_EXTERN_METHOD(setServerLocationCanada);
RCT_EXTERN_METHOD(setConfiguration:(NSDictionary *)configuration);
RCT_EXTERN_METHOD(setRequestCode:(NSInteger)requestCode);
RCT_EXTERN_METHOD(start:(NSString *)sessionID sessionToken:(NSString *)sessionToken completion:(RCTResponseSenderBlock)completion);

@end
