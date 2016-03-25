//
//  scheduleTableView.h
//  ezhayan
//
//  Created by ChenFengbo on 15/11/2.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface scheduleTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *dataArray;

@end
