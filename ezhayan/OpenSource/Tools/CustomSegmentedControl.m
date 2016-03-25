//
//  CustomSegmentedControl.m
//  Huake
//
//  Created by bingjun_lt on 15/2/3.
//  Copyright (c) 2015年 BingJun. All rights reserved.
//

#import "CustomSegmentedControl.h"
#import "UIViewExt.h"

@interface CustomSegmentedControl ()

@property (nonatomic) UIView *greenBg;

@end

@implementation CustomSegmentedControl

- (id)initWithFrame:(CGRect)frame withTitleArray:(NSArray *)titleArray withImageArray:(NSArray *)imageArray backgroundColor:(UIColor *)backgroundColor
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //self.layer.cornerRadius = 20;
        self.backgroundColor = backgroundColor;
        //self.clipsToBounds = YES;
        self.layer.borderColor = backgroundColor.CGColor;
        self.layer.borderWidth = 2;
        
        self.greenBg = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-5, frame.size.width/titleArray.count, 5)];
        self.greenBg.backgroundColor = appButtonColor;
        [self addSubview:self.greenBg];
        
        for (NSString *aTitle in titleArray) {
            NSInteger index = [titleArray indexOfObject:aTitle];
            UIButton *aButton = [[UIButton alloc] initWithFrame:CGRectMake(index * frame.size.width/titleArray.count, 0, frame.size.width/titleArray.count, frame.size.height)];
            [aButton setTitle:aTitle forState:UIControlStateNormal];
            aButton.layer.borderWidth = 1;
            aButton.layer.borderColor = backgroundColor.CGColor;
            if (imageArray.count > 0) {
                NSString *aImage = [imageArray objectAtIndex:index];
                [aButton setImage:[UIImage imageNamed:aImage] forState:UIControlStateNormal];
                [aButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -25, 0, 0)];
                if (kDeviceWidth>320) {
                    [aButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -(frame.size.width/titleArray.count-30)*2)];
                }else {
                    [aButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -(frame.size.width/titleArray.count-20)*2)];
                }
            }
            aButton.titleLabel.font = [UIFont systemFontOfSize:15];
            aButton.titleLabel.adjustsFontSizeToFitWidth = YES;
            aButton.tag = index;
            [aButton addTarget:self action:@selector(segAction:) forControlEvents:UIControlEventTouchUpInside];
            [aButton setTitleColor:[UIColor blackColor] forState:0];
            [self addSubview:aButton];
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(aButton.right-1, 7, 1, aButton.height-14)];
            line.backgroundColor = [UIColor lightGrayColor];
            [self addSubview:line];
            
        }
    }
    return self;
}

- (void)segAction:(UIButton *)sender
{
    self.greenBg.frame = CGRectMake(sender.left, sender.bottom-5, sender.width, 5);
    [_delegate segChanged:sender.tag];
}

@end
