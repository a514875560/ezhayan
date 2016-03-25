//
//  CustomSegmentedControl.h
//  Huake
//
//  Created by bingjun_lt on 15/2/3.
//  Copyright (c) 2015年 BingJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomSegControlDelegate <NSObject>

- (void)segChanged:(NSInteger)index;

@end

@interface CustomSegmentedControl : UIView

@property (nonatomic, assign) id<CustomSegControlDelegate> delegate;

- (id)initWithFrame:(CGRect)frame withTitleArray:(NSArray *)titleArray withImageArray:(NSArray *)imageArray backgroundColor:(UIColor *)backgroundColor;

@end
