//
//  Commtion.m
//  ezhayan
//
//  Created by ChenFengbo on 15/11/11.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "Commtion.h"
#import "KeychainItemWrapper.h"

@implementation Commtion

+ (instancetype)shareCommtion
{
    static Commtion *shareManage;
    if (shareManage == nil) {
        shareManage = [[Commtion alloc]init];
    }
    return shareManage;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _user = [[UserModel alloc] init];
        
        KeychainItemWrapper *itemWrapper = [self keychainItemWrapper];
        _user.tel = [itemWrapper objectForKey:(__bridge id)(kSecAttrAccount)];
        _user.pwd = [itemWrapper objectForKey:(__bridge id)(kSecValueData)];
    }
    return self;
}

//获取存储对象
- (KeychainItemWrapper *)keychainItemWrapper
{
    return [[KeychainItemWrapper alloc] initWithIdentifier:kKeyChainIdentifier accessGroup:nil];
}

//拦截设置用户方法, 存储用户
- (void)setUser:(UserModel *)user
{
    _user = user;
    KeychainItemWrapper *itemWrapper = [self keychainItemWrapper];
    [itemWrapper setObject:user.tel forKey:(__bridge id)(kSecAttrAccount)];
    [itemWrapper setObject:user.pwd forKey:(__bridge id)(kSecValueData)];
}

//重置用户
- (void)resetUser
{
    _user = nil;
    KeychainItemWrapper *itemWrapper = [self keychainItemWrapper];
    [itemWrapper resetKeychainItem];
}

//判断是否能自动登录
- (BOOL)isLogin
{
    if (_user.tel.length && _user.pwd.length) {
        return YES;
    }
    return NO;
}

@end
