//
//  PrivateApiHelper.m
//  Video Browser
//
//  Created by mayc on 2020/4/21.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

#import "PrivateApiHelper.h"


@implementation PrivateApiHelper

+ (void)registerWKProtocolSchemes {
    Class cls = NSClassFromString(@"WKBrowsingContextController");
    SEL sel = NSSelectorFromString(@"registerSchemeForCustomProtocol:");
    if ([cls respondsToSelector:sel]) {
        [[self hookSchemes] enumerateObjectsUsingBlock:^(NSString * _Nonnull scheme, NSUInteger idx, BOOL * _Nonnull stop) {
            [cls performSelector:sel withObject:scheme];
        }];
    }
}

+ (void)unregisterWKProtocolSchemes {
    Class cls = NSClassFromString(@"WKBrowsingContextController");
    SEL sel = NSSelectorFromString(@"unregisterSchemeForCustomProtocol:");
    if ([cls respondsToSelector:sel]) {
        [[self hookSchemes] enumerateObjectsUsingBlock:^(NSString * _Nonnull scheme, NSUInteger idx, BOOL * _Nonnull stop) {
            [cls performSelector:sel withObject:scheme];
        }];
    }
}

#pragma mark - Private
+ (NSArray<NSString *> *)hookSchemes {
    return @[@"http", @"https"];
}

@end
