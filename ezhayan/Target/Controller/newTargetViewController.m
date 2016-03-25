//
//  newTargetViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 15/10/27.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "newTargetViewController.h"
//#import "addTargetView.h"

#import "XLForm.h"

NSString *const kName = @"name";
NSString *const kDoWhat = @"doWhat";
NSString *const kHowTodo = @"howTodo";
NSString *const kRemarks = @"remarks";

@interface newTargetViewController ()<UIScrollViewDelegate>


//@property (nonatomic, strong) UIScrollView *scrollView;
//@property (nonatomic, strong) addTargetView *targetView;

@end

@implementation newTargetViewController


#pragma mark - life Circle

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"新建目标"];
    
    self.view.backgroundColor = appTableviewBgColor;
    UIBarButtonItem *rightBut = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(didRightBut:)];
    self.navigationItem.rightBarButtonItem = rightBut;
    
//    [self.view addSubview:self.scrollView];
    
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
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kName rowType:XLFormRowDescriptorTypeText title:@"名  称"];
    [row.cellConfigAtConfigure setObject:@"输入名称" forKey:@"textField.placeholder"];
    row.required = YES;
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"做什么"];
    [form addFormSection:section];
    
    // Title
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kDoWhat rowType:XLFormRowDescriptorTypeText title:@"目标详情"];
    [row.cellConfigAtConfigure setObject:@"输入描述" forKey:@"textField.placeholder"];
    row.required = YES;
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"怎么做"];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kHowTodo rowType:XLFormRowDescriptorTypeTextView title:@"达成方法"];
    row.required = YES;
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"备注"];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kRemarks rowType:XLFormRowDescriptorTypeTextView title:@"附加信息"];
    row.required = YES;
    [section addFormRow:row];
    
    self.form = form;
}

#pragma mark - didEvent

//- (void)didRightBut:(UIBarButtonItem *)sender
//{
//    if (_targetView.name.text.length > 0 && _targetView.content.text.length > 0 && _targetView.howToDo.text.length > 0 && _targetView.remarks.text.length > 0) {
//        [SVProgressHUD show];
//        [WXDataServer requestURL:@"ObjectiveEvent/saveObjective"
//                      httpMethod:@"GET"
//                          params:[@{@"md5saveObjective":[UIUtils encodeToPercentEscapeString:[UIUtils TripleDES:[NSString stringWithFormat:@"%@", [Commtion shareCommtion].user.client_id] encryptOrDecrypt:kCCEncrypt DESKEY:KEY]],
//                                    @"parent_objective_id":self.objId,
//                                    @"name":_targetView.name.text,
//                                    @"description":_targetView.content.text,
//                                    @"review":_targetView.howToDo.text,
//                                    @"summary":_targetView.remarks.text}mutableCopy]
//                            file:nil
//                         success:^(id data) {
//                             if([[NSString stringWithFormat:@"%@",data[@"success"]] isEqualToString:@"1"]){
//                                 
//                                 [SVProgressHUD showSuccessWithStatus:data[@"message"]];
//                                 [self.navigationController popViewControllerAnimated:YES];
//                             }
//                             else
//                             {
//                                 [SVProgressHUD showInfoWithStatus:data[@"message"]];
//                             }
//                         }
//                            fail:^(NSError *error) {
//                                [SVProgressHUD showErrorWithStatus:@"链接错误"];
//                                
//                            }];
//    }
//    else
//    {
//        [SVProgressHUD showErrorWithStatus:@"请输入完整的信息"];
//    }
//}

- (void)didRightBut:(UIBarButtonItem *)sender
{
    NSArray * validationErrors = [self formValidationErrors];
    if (validationErrors.count > 0){
        [self showFormValidationError:[validationErrors firstObject]];
        return;
    }
    [self.tableView endEditing:YES];
    
    NSDictionary *dict = self.form.formValues;
    [SVProgressHUD show];
    [WXDataServer requestURL:@"ObjectiveEvent/saveObjective"
                  httpMethod:@"GET"
                      params:[@{@"md5saveObjective":[UIUtils encodeToPercentEscapeString:[UIUtils TripleDES:[NSString stringWithFormat:@"%@", [Commtion shareCommtion].user.client_id] encryptOrDecrypt:kCCEncrypt DESKEY:KEY]],
                                @"parent_objective_id":self.objId,
                                @"name":dict[kName],
                                @"description":dict[kDoWhat],
                                @"review":dict[kHowTodo],
                                @"summary":dict[kRemarks]}mutableCopy]
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


#pragma mark - getter
//- (UIScrollView *)scrollView
//{
//    if (_scrollView == nil) {
//        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 25, kDeviceWidth, KDeviceHeight - 15)];
//        _scrollView.delegate = self;
//        _scrollView.contentSize = CGSizeMake(kDeviceWidth, 514);
//        [_scrollView addSubview:self.targetView];
//    }
//    return _scrollView;
//}
//
//- (addTargetView *)targetView
//{
//    if (_targetView == nil) {
//        _targetView = [[[NSBundle mainBundle] loadNibNamed:@"addTargetView" owner:self options:nil] lastObject];
//        _targetView.frame = CGRectMake(0, 0, kDeviceWidth, 514);
//    }
//    return _targetView;
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
