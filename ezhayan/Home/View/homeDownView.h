//
//  homeDownView.h
//  ezhayan
//
//  Created by ChenFengbo on 15/11/9.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homeDownView : UIView

@property (nonatomic,strong) void (^didTimeLine) (void);
@property (nonatomic,strong) void (^didMeChengJiu) (void);
@property (nonatomic,strong) void (^didSetting) (void);
@property (nonatomic,strong) void (^didToFirends) (void);

@end
