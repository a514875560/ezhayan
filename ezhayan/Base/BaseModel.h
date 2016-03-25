//
//  BaseModel.h
//  1.WXMovie
//
//  Created by elite on 14-8-22.
//  Copyright (c) 2014年 无限互联3G学院 www.iphonetrain.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 概述：“自动”设置属性值
 * 思路：
 *     （1）model和JSON[dic]建立映射关系
 *     （2）JSON的key就是model属性值，例外，JSON：id。处理，BaseModel + ID
 *     （3）生成setter字符串，例如，JSON：image，hehe
                model，image，(setImage:,image)
            通过给定JSON的key，生成字符串，"setImage:"
       （4）生成了setter字符串，生成SEL变量（指向一个方法，setter方法）
       （5）根据生成的方法设置model属性值
 */

@interface BaseModel : NSObject

- (id)initWithJSONDic:(NSDictionary *)json;

- (void)setValueForJSONKeysWithDictionary:(NSDictionary *)json;

@end
