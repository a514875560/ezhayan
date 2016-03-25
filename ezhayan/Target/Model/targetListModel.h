//
//  targetListModel.h
//  ezhayan
//
//  Created by ChenFengbo on 16/2/15.
//  Copyright © 2016年 ChenFengbo. All rights reserved.
//

#import "BaseModel.h"

@interface targetListModel : BaseModel

@property (nonatomic,strong) NSString *objective_id;
@property (nonatomic,strong) NSString *client_id;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *descrip;
@property (nonatomic,strong) NSString *review;
@property (nonatomic,strong) NSString *summary;
@property (nonatomic,strong) NSString *objnum;
@property (nonatomic,strong) NSString *schedulenum;
@property (nonatomic,strong) NSString *oknum;

@end
