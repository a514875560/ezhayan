//
//  RatingView.m
//  RatingView
//
//  Created by elite on 14-8-20.
//  Copyright (c) 2014年 无限互联3G学院 www.iphonetrain.com. All rights reserved.
//

#import "RatingView.h"
#import "UIViewExt.h"
#import "UIUtils.h"

@implementation RatingView

- (void)_initSubviews
{
//    _grayView = [[UIView alloc] initWithFrame:CGRectZero];
//    [self addSubview:_grayView];
    
    _yellowView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:_yellowView];
    
//    _ratingLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    _ratingLabel.backgroundColor = [UIColor clearColor];
//    _ratingLabel.textColor = [UIColor darkGrayColor];//[UIUtils colorWithHexString:@"29c983"];
//    _ratingLabel.font = [UIFont boldSystemFontOfSize:14];
//    [self addSubview:_ratingLabel];
}

- (void)awakeFromNib
{
    [self _initSubviews];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initSubviews];
    }
    return self;
}

// 首先父视图layoutsubviews 然后再调子视图
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 获取高度
    CGFloat height = self.height;
    
    
    // 设置比例
    UIImage *gray = [UIImage imageNamed:@"friend02_content_start"];
//    _grayView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shop_星2"]];
//    _grayView.transform = CGAffineTransformMakeScale(height/gray.size.width, height/gray.size.height);
    
    _yellowView.transform = CGAffineTransformMakeScale(height/gray.size.width, height/gray.size.height);
    _yellowView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"friend02_content_start"]];

    // 计算比例
    CGFloat rate = _rating / 5;
    
    // 总宽
    CGFloat allWidth = height * 5;
    
    //_grayView.frame = CGRectMake(0, 0, allWidth, height);
    _yellowView.frame = CGRectMake(0, 0, allWidth * rate, height);
    //_ratingLabel.frame = CGRectMake(_grayView.right + 5, 0, 40, height);
    //_ratingLabel.text = [NSString stringWithFormat:@"%.1f", _rating];
    
    // 设置frame
    //self.width = allWidth + 40;
 
    
}

@end






