//
//  targetListModel.m
//  ezhayan
//
//  Created by ChenFengbo on 16/2/15.
//  Copyright © 2016年 ChenFengbo. All rights reserved.
//

#import "targetListModel.h"

@implementation targetListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        self.descrip = value;
    }
}

@end
