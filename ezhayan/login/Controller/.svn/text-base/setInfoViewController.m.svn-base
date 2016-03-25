//
//  setInfoViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 15/11/11.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "setInfoViewController.h"
#import "baseTableViewCell.h"
#import "registerViewModel.h"
#import "baseImportViewController.h"
#import "headImageCell.h"

NSString * const kHeadImage = @"HeadImage";
NSString * const kNickName = @"NickName";
NSString * const kSex = @"Sex";
NSString * const kBrithday = @"Brithday";
NSString * const kWorkName = @"WorkName";
NSString * const kCompliary = @"Compliary";
NSString * const kAddress = @"Address";
NSString * const kEmail = @"Email";
NSString * const kPersonalsign = @"Personal_sign";

@interface setInfoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation setInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"注册资料";
    
    UIBarButtonItem *rightBut = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(didRightBut)];
    self.navigationItem.rightBarButtonItem = rightBut;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createTableView];
    }
    return self;
}

- (void)createTableView
{
    XLFormDescriptor *form;
    XLFormSectionDescriptor *section;
    XLFormRowDescriptor *row;
    
    form = [XLFormDescriptor formDescriptor];
    
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kHeadImage rowType:XLFormRowDescriptorTypeImage title:@"头像"];
//    row.cellClass = [headImageCell class];
    row.required = YES;
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kNickName rowType:XLFormRowDescriptorTypeName title:@"昵称"];
    [row.cellConfigAtConfigure setObject:@"输入昵称" forKey:@"textField.placeholder"];
    row.required = YES;
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kSex rowType:XLFormRowDescriptorTypeSelectorActionSheet title:@"性别"];
    row.required = YES;
    row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:@"0" displayText:@"男"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@"1" displayText:@"女"],
                            ];
    row.value = [XLFormOptionsObject formOptionsObjectWithValue:@"0" displayText:@"男"];
    row.required = YES;
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kBrithday rowType:XLFormRowDescriptorTypeDateInline title:@"生日"];
    row.value = [NSDate dateWithTimeIntervalSinceNow:0];
    row.required = YES;
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kWorkName rowType:XLFormRowDescriptorTypeSelectorPush title:@"职业"];
    row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"Option 1"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"Option 2"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"Option 3"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(3) displayText:@"Option 4"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(4) displayText:@"Option 5"]
                            ];
    row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"Option 3"];
    
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kCompliary rowType:XLFormRowDescriptorTypeSelectorPush title:@"公司"];
    row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"Option 1"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"Option 2"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"Option 3"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(3) displayText:@"Option 4"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(4) displayText:@"Option 5"]
                            ];
    row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"Option 3"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kAddress rowType:XLFormRowDescriptorTypeSelectorPush title:@"所在地"];
    row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"Option 1"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"Option 2"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"Option 3"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(3) displayText:@"Option 4"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(4) displayText:@"Option 5"]
                            ];
    row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"Option 3"];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kEmail rowType:XLFormRowDescriptorTypeEmail title:@"邮箱"];
    [row.cellConfigAtConfigure setObject:@"输入邮箱" forKey:@"textField.placeholder"];
    [row addValidator:[XLFormValidator emailValidator]];
    row.required = YES;
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPersonalsign rowType:XLFormRowDescriptorTypeTextView title:@"个人说明"];
    
    [section addFormRow:row];
    
    self.form = form;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didRightBut
{
    NSArray * validationErrors = [self formValidationErrors];
    if (validationErrors.count > 0){
        [self showFormValidationError:[validationErrors firstObject]];
        return;
    }
    [self.tableView endEditing:YES];
    
    NSDictionary *dict = self.form.formValues;
    UIImage *image = dict[kHeadImage];
    CGFloat f = [[NSDate date] timeIntervalSince1970] * 1000 * 1000;
    NSString *urlStr = [NSString stringWithFormat:@"/topic/%@/%.0f.JPG", [self yearMonthDay], f];
    [SVProgressHUD show];
    [WXDataServer requestURL:@"uploadTopicImg?category=user&type=1"
                  httpMethod:@"POST"
                      params:nil
                        file:@{urlStr:UIImageJPEGRepresentation(image, 1.0)}
                    fileName:@"uploadFile"
                    mimeType:@"application/octet-stream"
                     success:^(id data) {
                         [SVProgressHUD dismiss];
                         if([[NSString stringWithFormat:@"%@",data[@"success"]] isEqualToString:@"1"]){
                             [self saveInfo:data[@"data"]];
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

- (void)saveInfo:(NSString *)imgStr
{
    NSDictionary *dict = [self.form httpParameters:self];
    [WXDataServer requestURL:@"UserEvent/saveUserinfo"
                  httpMethod:@"GET"
                      params:[@{@"md5saveUserinfo":[UIUtils encodeToPercentEscapeString:[UIUtils TripleDES:[NSString stringWithFormat:@"%@", [Commtion shareCommtion].user.client_id] encryptOrDecrypt:kCCEncrypt DESKEY:KEY]],
                                @"nick_name":dict[kNickName],
                                @"head_url":imgStr,
                                @"gender":dict[kSex],
                                @"personal_sign":dict[kPersonalsign],
                                @"birthday":dict[kBrithday],
                                @"email":dict[kEmail]}mutableCopy]
                        file:nil
                     success:^(id data) {
                         if([[NSString stringWithFormat:@"%@",data[@"success"]] isEqualToString:@"1"]){
                            [SVProgressHUD showSuccessWithStatus:data[@"message"]];
                             [self.navigationController popToRootViewControllerAnimated:YES];
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

- (NSString *)yearMonthDay
{
    NSDate *senddate = [NSDate date];
    
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"yyyyMM/dd"];
    
    NSString *locationString = [dateformatter stringFromDate:senddate];
    
    return locationString;
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
