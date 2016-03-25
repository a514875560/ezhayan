//
//  targetNewScheduleViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 16/2/17.
//  Copyright © 2016年 ChenFengbo. All rights reserved.
//

#import "EZYtargetNewScheduleViewController.h"

NSString *const kNewScheduleName = @"scheduleName";
NSString *const kNewScheduleStarTime = @"scheduleStarTime";
NSString *const kNewScheduleEndTime = @"scheduleEndTime";
NSString *const kNewIsOpenRemind = @"isOpenRemind";
NSString *const kNewScheduleRepeat = @"schedultRepeat";
NSString *const kNewScheduleRemarks = @"scheduleRemarks";

@interface EZYtargetNewScheduleViewController ()

@end

@implementation EZYtargetNewScheduleViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeForm];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initializeForm];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    XLFormRowDescriptor *row = [self.form formRowWithTag:kNewScheduleName];
    row.value = self.objName;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initForm
- (void)initializeForm
{
    XLFormDescriptor * form;
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    form = [XLFormDescriptor formDescriptor];
    section = [XLFormSectionDescriptor formSectionWithTitle:@"目标名称"];
    [form addFormSection:section];
    
    // Title
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kNewScheduleName rowType:XLFormRowDescriptorTypeText title:@"名  称："];
    row.disabled = @YES;
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"选择时间"];
    [form addFormSection:section];
    
    // Starts
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kNewScheduleStarTime rowType:XLFormRowDescriptorTypeDateTimeInline title:@"开始时间："];
    row.value = [NSDate dateWithTimeIntervalSinceNow:0];
    [section addFormRow:row];
    
    // Ends
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kNewScheduleEndTime rowType:XLFormRowDescriptorTypeDateTimeInline title:@"结束时间："];
    row.value = [NSDate dateWithTimeIntervalSinceNow:60*60];
    [section addFormRow:row];
    
    // All-day
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kNewIsOpenRemind rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"开启提醒"];
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"重复"];
    [form addFormSection:section];
    
    // Repeat
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kNewScheduleRepeat rowType:XLFormRowDescriptorTypeSelectorPush title:@"重复周期"];
    row.value = [XLFormOptionsObject formOptionsObjectWithValue:@"0" displayText:@"不重复"];
    row.selectorTitle = @"重复周期";
    row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:     @"0" displayText:@"不重复"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@"1" displayText:@"每日重复"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@"2" displayText:@"每周重复"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@"3" displayText:@"每月重复"],
                            ];
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"描述"];
    [form addFormSection:section];
    
    // Notes
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kNewScheduleRemarks rowType:XLFormRowDescriptorTypeTextView];
    [row.cellConfigAtConfigure setObject:@"请输入描述" forKey:@"textView.placeholder"];
    row.required = YES;
    [section addFormRow:row];
    
    
    self.form = form;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
