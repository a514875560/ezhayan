//
//  newToDoViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 15/10/30.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "newToDoViewController.h"
#import "todoSelectorClassViewController.h"
#import "todoSelectFriendViewController.h"

NSString *const kPerson = @"person";
NSString *const kTodoName = @"todoName";
NSString *const kSetTime = @"setTime";
NSString *const kSomeThing = @"sonmeThing";
NSString *const kClass = @"class";
NSString *const kPhoto = @"photo";
NSString *const kTakePrecedence = @"takePrecedence";

@interface newToDoViewController ()<UIScrollViewDelegate>

//@property (nonatomic,strong) UIScrollView *scrollView;
//@property (nonatomic,strong) addTodoView *toDoView;

@end

@implementation newToDoViewController

- (instancetype)init
{
    self = [super init];
    if (self ) {
        [self initializeForm];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeForm];
    }
    return self;
}

#pragma mark -life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.view addSubview:self.scrollView];
//    [_scrollView addSubview:self.toDoView];
    
    self.view.backgroundColor = appTableviewBgColor;
    
    self.navigationItem.title = @"新建待办";
    
    UIBarButtonItem *rightBut = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(didRightBut:)];
    self.navigationItem.rightBarButtonItem = rightBut;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - initForm
- (void)initializeForm
{
    XLFormDescriptor * form;
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    form = [XLFormDescriptor formDescriptor];
    section = [XLFormSectionDescriptor formSectionWithTitle:@"处理人"];
    [form addFormSection:section];
    
    // Title
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPerson rowType:XLFormRowDescriptorTypeSelectorPush title:@"选择人物："];
    row.action.viewControllerClass = [todoSelectFriendViewController class];
    row.required = YES;
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"待办详情"];
    [form addFormSection:section];
    
    // Title
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kTodoName rowType:XLFormRowDescriptorTypeText title:@"事件详情："];
    [row.cellConfigAtConfigure setObject:@"输入名称" forKey:@"textField.placeholder"];
    row.required = YES;
    [section addFormRow:row];
    
    // Starts
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kSetTime rowType:XLFormRowDescriptorTypeDateTimeInline title:@"设置时间："];
    row.value = [NSDate dateWithTimeIntervalSinceNow:0];
    [section addFormRow:row];
    
    // Notes
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kSomeThing rowType:XLFormRowDescriptorTypeTextView];
    [row.cellConfigAtConfigure setObject:@"内容描述" forKey:@"textView.placeholder"];
    row.required = YES;
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"标签"];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kClass rowType:XLFormRowDescriptorTypeSelectorPush title:@"待办分类："];
    row.action.viewControllerClass = [todoSelectorClassViewController class];
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"优先级"];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kTakePrecedence rowType:XLFormRowDescriptorTypeSelectorPush title:@"设置优先级："];
    row.value = [XLFormOptionsObject formOptionsObjectWithValue:@"1" displayText:@"紧急重要"];
    row.selectorTitle = @"优先级";
    row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:     @"1" displayText:@"紧急重要"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@"2" displayText:@"不紧急重要"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@"3" displayText:@"紧急不重要"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@"4" displayText:@"不紧急不重要"],
                            ];
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
    NSString *starTime = [formmatter stringFromDate:dict[kSetTime]];
    
    [SVProgressHUD show];
    [WXDataServer requestURL:@"TodoEvent/saveTodo"
                  httpMethod:@"GET"
                      params:[@{@"md5saveTodo":[UIUtils encodeToPercentEscapeString:[UIUtils TripleDES:[NSString stringWithFormat:@"%@:%@", dict[kPerson],[Commtion shareCommtion].user.client_id] encryptOrDecrypt:kCCEncrypt DESKEY:KEY]],
                                @"td_id":dict[kClass],
                                @"require_time":starTime,
                                @"name":dict[kTodoName],
                                @"Weight":dict[kTakePrecedence],
                                @"Image":@"",
                                @"description":dict[kSomeThing]}mutableCopy]
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
//        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight)];
//        _scrollView.delegate = self;
//        _scrollView.contentSize = CGSizeMake(kDeviceWidth, 667);
//        return _scrollView;
//    }
//    return _scrollView;
//}
//
//- (addTodoView *)toDoView
//{
//    if (_toDoView == nil) {
//        _toDoView = [[[NSBundle mainBundle] loadNibNamed:@"addTodoView" owner:self options:nil] lastObject];
//        return _toDoView;
//    }
//    return _toDoView;
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
