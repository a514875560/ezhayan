//
//  todoListCollectionReusableView.h
//  ezhayan
//
//  Created by ChenFengbo on 15/11/6.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "todoHomeListModel.h"

@interface todoListCollectionReusableView : UICollectionReusableView

@property (nonatomic,strong) todoHomeListModel *model;

@property (nonatomic,strong) void (^didWillDo) (void);
@property (nonatomic,strong) void (^didFinshDo) (void);
@property (nonatomic,strong) void (^didWillSend) (void);
@property (nonatomic,strong) void (^didFinshSend) (void);

@end
