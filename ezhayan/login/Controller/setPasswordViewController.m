//
//  setPasswordViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 15/11/11.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "setPasswordViewController.h"
#import "setInfoViewController.h"

@interface setPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *onePwd;
@property (weak, nonatomic) IBOutlet UITextField *twoPwd;

@end

@implementation setPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"设置密码";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didNext:(UIButton *)sender {
    if ([_onePwd.text isEqualToString:_twoPwd.text]) {
        [SVProgressHUD show];
        [WXDataServer requestURL:@"UserEvent/saveUserinfo"
                      httpMethod:@"GET"
                          params:[@{@"md5saveUserinfo":[UIUtils encodeToPercentEscapeString:[UIUtils TripleDES:[NSString stringWithFormat:@"%@", _client_id] encryptOrDecrypt:kCCEncrypt DESKEY:KEY]],
                                    @"pwd":_twoPwd.text}mutableCopy]
                            file:nil
                         success:^(id data) {
                             if([[NSString stringWithFormat:@"%@",data[@"success"]] isEqualToString:@"1"]){
                                 
                                 [SVProgressHUD showSuccessWithStatus:data[@"message"]];
                                 [Commtion shareCommtion].user.pwd = _twoPwd.text;
                                 setInfoViewController *setInfo = [[setInfoViewController alloc]init];
                                 [self.navigationController pushViewController:setInfo animated:YES];
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
        [SVProgressHUD showErrorWithStatus:@"两次输入的密码不同"];
    }
    
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
