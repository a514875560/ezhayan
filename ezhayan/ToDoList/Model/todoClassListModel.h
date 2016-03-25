//
//  todoClassListModel.h
//  ezhayan
//
//  Created by ChenFengbo on 16/2/22.
//  Copyright © 2016年 ChenFengbo. All rights reserved.
//

#import "BaseModel.h"

@interface todoClassListModel : BaseModel

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *count;
@property (nonatomic,strong) NSString *td_id;

@end
