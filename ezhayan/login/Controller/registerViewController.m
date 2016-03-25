//
//  registerViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 15/11/11.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "registerViewController.h"
#import "setPasswordViewController.h"
#import "setInfoViewController.h"

@interface registerViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *testNum;

@end

@implementation registerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"注册";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didGetTest:(UIButton *)sender {
    if (_phoneNum.text.length == 11) {
        [SVProgressHUD show];
        [WXDataServer requestURL:@"UserEvent/sendMobileCode"
                      httpMethod:@"GET"
                          params:[@{@"md5sendMobileCode":[UIUtils encodeToPercentEscapeString:[UIUtils TripleDES:[NSString stringWithFormat:@"%@", _phoneNum.text] encryptOrDecrypt:kCCEncrypt DESKEY:KEY]]}mutableCopy]
                            file:nil
                         success:^(id data) {
                             if([[NSString stringWithFormat:@"%@",data[@"success"]] isEqualToString:@"1"]){
                                 [SVProgressHUD showSuccessWithStatus:data[@"message"]];
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
    else
    {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
    }
}

- (IBAction)didNext:(UIButton *)sender {
    if (_testNum.text.length == 4 && _phoneNum.text.length == 11) {
        [SVProgressHUD show];
        [WXDataServer requestURL:@"UserEvent/register"
                      httpMethod:@"GET"
                          params:[@{@"md5register":[UIUtils encodeToPercentEscapeString:[UIUtils TripleDES:[NSString stringWithFormat:@"%@:%@", _phoneNum.text,_testNum.text] encryptOrDecrypt:kCCEncrypt DESKEY:KEY]]}mutableCopy]
                            file:nil
                         success:^(id data) {
                             if([[NSString stringWithFormat:@"%@",data[@"success"]] isEqualToString:@"1"]){
                                 
                                 [SVProgressHUD showSuccessWithStatus:data[@"message"]];
                                 [Commtion shareCommtion].user.tel = _phoneNum.text;
                                 [Commtion shareCommtion].user.client_id = [NSString stringWithFormat:@"%@",data[@"data"]];
                                 setPasswordViewController *setPwd = [[setPasswordViewController alloc]init];
                                 setPwd.client_id = [Commtion shareCommtion].user.client_id;
                                 [self.navigationController pushViewController:setPwd animated:YES];
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
    else
    {
        [SVProgressHUD showErrorWithStatus:@"请输入完整的验证吗"];
    }
    
}

- (IBAction)didAgree:(UIButton *)sender {
    if (sender.selected) {
        sender.selected = NO;
    }
    else
    {
        sender.selected = YES;
    }
}

- (IBAction)didXieyi:(UIButton *)sender {
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
