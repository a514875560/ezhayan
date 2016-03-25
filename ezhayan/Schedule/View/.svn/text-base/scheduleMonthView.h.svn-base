//
//  scheduleMonthView.h
//  ezhayan
//
//  Created by ChenFengbo on 15/11/4.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CalendarItemDelegate;


@interface scheduleMonthView : UIView

@property (weak, nonatomic) id<CalendarItemDelegate> delegate;
@property (nonatomic,strong) void (^didSuccess) (void);
@property (nonatomic,strong) void (^didDoing) (void);
@property (nonatomic,strong) void (^didWillDo) (void);

@end

@protocol CalendarItemDelegate <NSObject>

- (void)calendarItem:(scheduleMonthView *)item didSelectedDate:(NSDate *)date;

@end

