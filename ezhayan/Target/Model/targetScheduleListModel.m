//
//  targetScheduleListModel.m
//  ezhayan
//
//  Created by ChenFengbo on 16/2/16.
//  Copyright © 2016年 ChenFengbo. All rights reserved.
//

#import "targetScheduleListModel.h"

@implementation targetScheduleListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        self.content = value;
    }
}

@end
