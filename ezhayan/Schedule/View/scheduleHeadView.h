//
//  scheduleHeadView.h
//  ezhayan
//
//  Created by ChenFengbo on 15/11/2.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "targetScheduleListModel.h"

@interface scheduleHeadView : UITableViewHeaderFooterView

@property (nonatomic,strong) targetScheduleListModel *model;
@property (nonatomic, strong) void (^didOpen) (BOOL b);

@end
