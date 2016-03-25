//
//  targetAddScheduleViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 16/2/16.
//  Copyright © 2016年 ChenFengbo. All rights reserved.
//

#import "targetAddScheduleViewController.h"
//#import "addScheduleView.h"

NSString *const kScheduleName = @"scheduleName";
NSString *const kScheduleStarTime = @"scheduleStarTime";
NSString *const kScheduleEndTime = @"scheduleEndTime";
NSString *const kIsOpenRemind = @"isOpenRemind";
NSString *const kScheduleRepeat = @"schedultRepeat";
NSString *const kScheduleRemarks = @"scheduleRemarks";

@interface targetAddScheduleViewController ()<UIScrollViewDelegate>

//@property (nonatomic,strong) addScheduleView *scheduleView;
//@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation targetAddScheduleViewController

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
    [self setTitle:@"新建日程"];
    
    self.view.backgroundColor = appTableviewBgColor;
    UIBarButtonItem *rightBut = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(didRightBut:)];
    self.navigationItem.rightBarButtonItem = rightBut;
    
//    [self.view addSubview:self.scrollView];
    XLFormRowDescriptor *row = [self.form formRowWithTag:kScheduleName];
    row.value = self.objName;
    
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
    section = [XLFormSectionDescriptor formSectionWithTitle:@"目标名称"];
    [form addFormSection:section];
    
    // Title
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kScheduleName rowType:XLFormRowDescriptorTypeText title:@"名  称："];
    row.disabled = @YES;
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"选择时间"];
    [form addFormSection:section];
    
    // Starts
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kScheduleStarTime rowType:XLFormRowDescriptorTypeDateTimeInline title:@"开始时间："];
    row.value = [NSDate dateWithTimeIntervalSinceNow:0];
    [section addFormRow:row];
    
    // Ends
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kScheduleEndTime rowType:XLFormRowDescriptorTypeDateTimeInline title:@"结束时间："];
    row.value = [NSDate dateWithTimeIntervalSinceNow:60*60];
    [section addFormRow:row];
    
    // All-day
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kIsOpenRemind rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"开启提醒"];
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"重复"];
    [form addFormSection:section];
    
    // Repeat
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kScheduleRepeat rowType:XLFormRowDescriptorTypeSelectorPush title:@"重复周期"];
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
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kScheduleRemarks rowType:XLFormRowDescriptorTypeTextView];
    [row.cellConfigAtConfigure setObject:@"请输入描述" forKey:@"textView.placeholder"];
    row.required = YES;
    [section addFormRow:row];
    
    
    self.form = form;
}

#pragma mark - didEvent

- (void)didRightBut:(UIBarButtonItem *)sender
{
    NSArray * validationErrors = [self formValidationErrors];
    if (validationErrors.count > 0){
        [self showFormValidationError:[validationErrors firstObject]];
        return;
    }
    [self.tableView endEditing:YES];
    
    NSDictionary *dict = [self.form httpParameters:self];
    
    NSDateFormatter *formmatter = [[NSDateFormatter alloc]init];
    [formmatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *starTime = [formmatter stringFromDate:dict[kScheduleStarTime]];
    NSString *endTime = [formmatter stringFromDate:dict[kScheduleEndTime]];
    
    [SVProgressHUD show];
    [WXDataServer requestURL:@"ScheduleEvent/saveSchedule"
                  httpMethod:@"GET"
                      params:[@{@"md5saveSchedule":[UIUtils encodeToPercentEscapeString:[UIUtils TripleDES:[NSString stringWithFormat:@"%@", [Commtion shareCommtion].user.client_id] encryptOrDecrypt:kCCEncrypt DESKEY:KEY]],
                                @"objective_id":self.objId,
                                @"starttime":starTime,
                                @"overtime":endTime,
                                @"cycle":dict[kScheduleRepeat],
                                @"cycle_over_time":@"",
                                @"description":dict[kScheduleRemarks]}mutableCopy]
                        file:nil
                     success:^(id data) {
                         if([[NSString stringWithFormat:@"%@",data[@"success"]] isEqualToString:@"1"]){
                             
                             [SVProgressHUD showSuccessWithStatus:data[@"message"]];
                             [self.navigationController popViewControllerAnimated:YES];
                         }
                         else
                         {
                             [SVProgressHUD showInfoWithStatus:data[@"message"]];
                         }
                     }
                        fail:^(NSError *error) {
                            [SVProgressHUD showErrorWithStatus:@"链接错误"];
                            
                        }];
}

//#pragma mark - getter
//- (UIScrollView *)scrollView
//{
//    if (_scrollView == nil) {
//        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 25, kDeviceWidth, KDeviceHeight - 15)];
//        _scrollView.delegate = self;
//        _scrollView.contentSize = CGSizeMake(kDeviceWidth, 514);
//        [_scrollView addSubview:self.scheduleView];
//    }
//    return _scrollView;
//}
//
//- (addScheduleView *)scheduleView
//{
//    if (_scheduleView == nil) {
//        _scheduleView = [[[NSBundle mainBundle] loadNibNamed:@"addScheduleView" owner:self options:nil] lastObject];
//        _scheduleView.frame = CGRectMake(0, 0, kDeviceWidth, 514);
//    }
//    return _scheduleView;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
