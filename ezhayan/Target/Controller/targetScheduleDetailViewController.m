//
//  targetScheduleDetailViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 16/2/18.
//  Copyright © 2016年 ChenFengbo. All rights reserved.
//

#import "targetScheduleDetailViewController.h"

@interface targetScheduleDetailViewController ()

@end

@implementation targetScheduleDetailViewController

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
    self.navigationItem.title = @"日程详情";
    
    self.view.backgroundColor = appTableviewBgColor;
    UIBarButtonItem *rightBut = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"schedule9_nav_sc"] style:UIBarButtonItemStylePlain target:self action:@selector(didRightBut:)];
    self.navigationItem.rightBarButtonItem = rightBut;
    
    XLFormRowDescriptor *rowName = [self.form formRowWithTag:@"ScheduleName"];
    if (self.objName) {
        rowName.value = self.objName;
    }
    else
    {
        rowName.value = self.scheduleModel.name;
    }
    
    NSDateFormatter *formmatter = [[NSDateFormatter alloc]init];
    [formmatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *starTime = [formmatter dateFromString:self.scheduleModel.start_time];
    NSDate *endTime = [formmatter dateFromString:self.scheduleModel.over_time];
    
    XLFormRowDescriptor *rowStarTime = [self.form formRowWithTag:@"ScheduleStarTime"];
    rowStarTime.value = starTime;
    
    XLFormRowDescriptor *rowEndTime = [self.form formRowWithTag:@"ScheduleEndTime"];
    rowEndTime.value = endTime;
    
    XLFormRowDescriptor *rowOpenRemind = [self.form formRowWithTag:@"IsOpenRemind"];
    rowOpenRemind.value = @"已开启";
    
    XLFormRowDescriptor *rowRemarks = [self.form formRowWithTag:@"ScheduleRemarks"];
    rowRemarks.value = self.scheduleModel.content;
    
    XLFormRowDescriptor *rowSuccess = [self.form formRowWithTag:@"isSuccess"];
    NSTimeInterval diffictTime = [endTime timeIntervalSinceNow];
    if (diffictTime < 0) {
        rowSuccess.value = @"已完成";
    }
    else
    {
        rowSuccess.value = @"未完成";
    }
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
    section = [XLFormSectionDescriptor formSectionWithTitle:@"目标"];
    [form addFormSection:section];
    
    // Title
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"ScheduleName" rowType:XLFormRowDescriptorTypeText title:@"名称："];
    row.disabled = @YES;
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"选择时间"];
    [form addFormSection:section];
    
    // Starts
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"ScheduleStarTime" rowType:XLFormRowDescriptorTypeDateTimeInline title:@"开始时间："];
    row.disabled = @YES;
    [section addFormRow:row];
    
    // Ends
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"ScheduleEndTime" rowType:XLFormRowDescriptorTypeDateTimeInline title:@"结束时间："];
    row.disabled = @YES;
    [section addFormRow:row];
    
    // All-day
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"IsOpenRemind" rowType:XLFormRowDescriptorTypeText title:@"开启提醒"];
    row.disabled = @YES;
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"描述"];
    [form addFormSection:section];
    
    // Notes
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"ScheduleRemarks" rowType:XLFormRowDescriptorTypeTextView];
    row.disabled = @YES;
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"完成情况"];
    [form addFormSection:section];
    
    // Notes
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"isSuccess" rowType:XLFormRowDescriptorTypeText title:@"状态："];
    row.disabled = @YES;
    [section addFormRow:row];
    
    self.form = form;
}

#pragma mark - didEvent
- (void)didRightBut:(UIBarButtonItem *)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"你确定删除这个日程吗？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [WXDataServer requestURL:@"ScheduleEvent/deleteSchedule"
                      httpMethod:@"GET"
                          params:[@{@"md5deleteSchedule":[UIUtils encodeToPercentEscapeString:[UIUtils TripleDES:[NSString stringWithFormat:@"%@",self.scheduleModel.sr_id] encryptOrDecrypt:kCCEncrypt DESKEY:KEY]]} mutableCopy]
                            file:nil
                         success:^(id data) {
                             if([[NSString stringWithFormat:@"%@",data[@"success"]] isEqualToString:@"1"]){
                                 
                                 [self.navigationController popViewControllerAnimated:YES];
                                 
                             }else {
                                 [SVProgressHUD showInfoWithStatus:data[@"message"]];
                             }
                             
                         }
                            fail:^(NSError *error) {
                                [SVProgressHUD showErrorWithStatus:@"链接错误"];
                            }];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
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
