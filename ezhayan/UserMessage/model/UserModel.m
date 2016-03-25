//
//  UserModel.m
//  ezhayan
//
//  Created by ChenFengbo on 15/11/11.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        self.descrip = value;
    }
}

@end
