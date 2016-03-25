//
//  Commtion.h
//  ezhayan
//
//  Created by ChenFengbo on 15/11/11.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface Commtion : NSObject

@property (nonatomic, strong) UserModel *user;

+ (instancetype)shareCommtion;
//重置用户
- (void)resetUser;
//判断是否能登录
- (BOOL)isLogin;

@end
