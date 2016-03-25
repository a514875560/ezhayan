//
//  timeLineTableViewCell.m
//  ezhayan
//
//  Created by ChenFengbo on 15/11/9.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "timeLineTableViewCell.h"
#import "UIColor+RandomColor.h"
#import "ZFProgressView.h"

@interface timeLineTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (weak, nonatomic) IBOutlet UIView *progressView;
@property (strong, nonatomic) ZFProgressView *zfProgress;

@end

@implementation timeLineTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    _colorView.layer.cornerRadius = 6;
    _colorView.layer.masksToBounds = YES;
    
}

- (void)layoutSubviews
{
    UIColor *randColor = [UIColor randomColor];
    _colorView.backgroundColor = randColor;
    _topNum.textColor = randColor;
    [self.progressView addSubview:self.zfProgress];
    
    _zfProgress.progressStrokeColor = randColor;
    _zfProgress.backgroundStrokeColor = [UIUtils colorWithHexString:@"#ededed"];
    _zfProgress.digitTintColor = randColor;
    
    [_zfProgress setProgress:0.5 Animated:YES];
    
}

- (ZFProgressView *)zfProgress
{
    if (_zfProgress == nil) {
        _zfProgress = [[ZFProgressView alloc]initWithFrame:_progressView.bounds];
        _zfProgress.progressLineWidth = 5;
        _zfProgress.backgourndLineWidth = 5;
        _zfProgress.offset = 0;
        _zfProgress.textFont = 20;
    }
    return _zfProgress;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
