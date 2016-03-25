//
//  WXItemView.h
//  项目1.1
//
//  Created by mac1 on 14-8-19.
//  Copyright (c) 2014年 冷婷. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WXItemViewDelegate <NSObject>

- (void)didSelectItemViewWithIndex:(NSInteger)index;

@end

@interface WXItemView : UIView
{
    UIButton *_itemButton;
    UILabel *_textLable;
}

@property (nonatomic, assign) id<WXItemViewDelegate> delegate;

@property (nonatomic, assign) UIViewController *target;

@property (nonatomic, readonly, retain) UIButton *itemButton;
@property (nonatomic, readonly, retain) UILabel *textLable;

@end
