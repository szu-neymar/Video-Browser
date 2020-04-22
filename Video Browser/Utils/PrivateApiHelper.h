//
//  PrivateApiHelper.h
//  Video Browser
//
//  Created by mayc on 2020/4/21.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PrivateApiHelper : NSObject

// 注册 WKWebView 网络监听
+ (void)registerWKProtocolSchemes;
// 注销 WKWebView 网络监听
+ (void)unregisterWKProtocolSchemes;

@end

NS_ASSUME_NONNULL_END
