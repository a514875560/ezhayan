//
//  DKTagCloudView.m
//  DKTagCloudViewDemo
//
//  Created by ZhangAo on 14-11-18.
//  Copyright (c) 2014年 zhangao. All rights reserved.
//

#import "DKTagCloudView.h"

@interface DKTagCloudView ()

@property (nonatomic, strong) NSMutableArray *labels;

@end

@implementation DKTagCloudView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.userInteractionEnabled = YES;
    self.minFontSize = 14;
    self.maxFontSize = 20;
    self.randomColors = @[
                          [UIUtils colorWithHexString:@"cc00ca"],
                          [UIUtils colorWithHexString:@"e40000"],
                          [UIUtils colorWithHexString:@"606060"],
                          [UIUtils colorWithHexString:@"e48b00"],
                          [UIUtils colorWithHexString:@"026ec1"]
                          ];
}

- (UIColor *)randomColor {
    return self.randomColors[rand() % self.randomColors.count];
}

- (UIFont *)randomFont {
    return [UIFont systemFontOfSize:rand() % self.maxFontSize + self.minFontSize];
}

- (CGRect)randomFrameForLabel:(UILabel *)label {
    [label sizeToFit];
    CGFloat maxWidth = self.bounds.size.width - label.bounds.size.width;
    CGFloat maxHeight = self.bounds.size.height - label.bounds.size.height;
    
    return CGRectMake(random() % (NSInteger)maxWidth, random() % (NSInteger)maxHeight,
                      CGRectGetWidth(label.bounds), CGRectGetHeight(label.bounds));
}

- (BOOL)frameIntersects:(CGRect)frame {
    for (UILabel *label in self.labels) {
        if (CGRectIntersectsRect(frame, label.frame)) {
            return YES;
        }
    }
    return NO;
}

- (NSMutableArray *)labels {
    if (_labels == nil) {
        _labels = [NSMutableArray new];
    }
    return _labels;
}

- (void)generate {
    [self.labels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.labels removeAllObjects];
    
    int i = 0;
    for (NSString *title in self.titls) {
        assert([title isKindOfClass:[NSString class]]);
        
        UILabel *label = [[UILabel alloc] init];
        label.tag = i++;
        label.text = title;
        label.textColor = [self randomColor];
        label.font = [self randomFont];
        label.frame = [self randomFrameForLabel:label];
        do {
            label.frame = [self randomFrameForLabel:label];
        } while ([self frameIntersects:label.frame]);
        
        [self.labels addObject:label];
        [self addSubview:label];
        
        UITapGestureRecognizer *tagGestue = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        [label addGestureRecognizer:tagGestue];
        label.userInteractionEnabled = YES;
    }
}

- (void)handleGesture:(UIGestureRecognizer*)gestureRecognizer {
    UILabel *label = (UILabel *)gestureRecognizer.view;
    if (self.tagClickBlock) {
        self.tagClickBlock(label.text,label.tag);
    }
}

@end
