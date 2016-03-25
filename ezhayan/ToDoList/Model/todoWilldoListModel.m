//
//  todoWilldoListModel.m
//  ezhayan
//
//  Created by ChenFengbo on 16/2/23.
//  Copyright © 2016年 ChenFengbo. All rights reserved.
//

#import "todoWilldoListModel.h"

@implementation todoWilldoListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        self.content = value;
    }
}

@end
