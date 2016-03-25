//
//  SelectView.h
//  Huake
//
//  Created by bingjun_lt on 15/1/13.
//  Copyright (c) 2015年 BingJun. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SelectViewCellHeight 30
typedef void(^selfToNil)();

@protocol SelectViewDelegate <NSObject>

- (void)selectOption:(NSString *)selectedOption selectView:(UIView *)view;

@end

@interface SelectView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) selfToNil block;
@property (nonatomic, assign) id<SelectViewDelegate> delegate;
@property (nonatomic, assign) NSInteger cellHeight;
- (id)initWithFrame:(CGRect)frame withDataArray:(NSArray *)dataArray withTableViewFrame:(CGRect)tableViewFrame withTextColor:(UIColor *)textColor withTextFont:(UIFont *)textFont withImageArray:(NSArray *)imageArray tableColor:(UIColor *)tableColor;

@end
