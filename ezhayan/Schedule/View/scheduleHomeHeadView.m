//
//  scheduleHomeHeadView.m
//  ezhayan
//
//  Created by ChenFengbo on 15/11/2.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "scheduleHomeHeadView.h"
#import "ZFProgressView.h"
#import "Masonry.h"

#define progressViewHeight(x) x * 266 / 375 - 104

@interface scheduleHomeHeadView ()

@property (weak, nonatomic) IBOutlet UIView *baseView;

@end

@implementation scheduleHomeHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib
{
    CGFloat height = progressViewHeight(kDeviceWidth);
    ZFProgressView *progressView = [[ZFProgressView alloc]initWithFrame:CGRectMake((kDeviceWidth - height) / 2, 15, height, height)];
    progressView.progressLineWidth = 12;
    progressView.backgourndLineWidth = 12;
    progressView.offset = -4;
    progressView.progressStrokeColor = [UIUtils colorWithHexString:@"#00d0a4"];
    progressView.backgroundStrokeColor = [UIUtils colorWithHexString:@"#323944"];
    progressView.digitTintColor = [UIUtils colorWithHexString:@"#00d0a4"];
    [self.baseView addSubview:progressView];
    [progressView setProgress:0.5 Animated:YES];
}

//- (void)createStarView
//{
//    UIView *_grayView = [[UIView alloc] initWithFrame:CGRectZero];
//    [self addSubview:_grayView];
//    UIView *_yellowView = [[UIView alloc] initWithFrame:CGRectZero];
//    [self addSubview:_yellowView];
//    UIImage *gray = [UIImage imageNamed:@"schedule3_content_icoh_n"];
//    _grayView.backgroundColor = [UIColor colorWithPatternImage:gray];
//    _grayView.transform = CGAffineTransformMakeScale(ratingView.height/gray.size.width, ratingView.height/gray.size.height);
//    
//    _yellowView.transform = CGAffineTransformMakeScale(ratingView.height/gray.size.width, ratingView.height/gray.size.height);
//    _yellowView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"schedule3_content_icoh_h"]];
//    // 计算比例
//    CGFloat rate = [_model.avglevel floatValue] / 5;
//    // 总宽
//    CGFloat allWidth = ratingView.height * 5;
//    _grayView.frame = CGRectMake(0, 0, allWidth, ratingView.height);
//    _yellowView.frame = CGRectMake(0, 0, allWidth * rate, ratingView.height);
//}

@end
