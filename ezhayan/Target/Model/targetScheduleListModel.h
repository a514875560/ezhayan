//
//  targetScheduleListModel.h
//  ezhayan
//
//  Created by ChenFengbo on 16/2/16.
//  Copyright © 2016年 ChenFengbo. All rights reserved.
//

#import "BaseModel.h"

@interface targetScheduleListModel : BaseModel

@property (nonatomic,strong) NSString *sr_id;
@property (nonatomic,strong) NSString *objective_id;
@property (nonatomic,strong) NSString *root_objective_id;
@property (nonatomic,strong) NSString *start_time;
@property (nonatomic,strong) NSString *over_time;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *name;

@end
