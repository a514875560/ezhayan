//
//  loginViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 15/11/11.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "loginViewController.h"
#import "registerViewController.h"
#import "MainViewController.h"

#import "isOpenHandViewController.h"
#import "baseNavigationCtrl.h"


@interface loginViewController ()<UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *registerBut;
@property (weak, nonatomic) IBOutlet UIButton *loginBut;

@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"loginControllerTitle", @"Title");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - actionEvent

- (IBAction)didRegister:(UIButton *)sender {
    registerViewController *registerCtrl = [[registerViewController alloc]init];
    [self.navigationController pushViewController:registerCtrl animated:YES];
}

- (IBAction)didLogin:(UIButton *)sender {
    if (_userName.text.length > 0 && _password.text.length > 0) {
        [SVProgressHUD show];
        [WXDataServer requestURL:@"UserEvent/login"
                      httpMethod:@"GET"
                          params:[@{@"md5login":[UIUtils encodeToPercentEscapeString:[UIUtils TripleDES:[NSString stringWithFormat:@"%@:%@", _userName.text,_password.text] encryptOrDecrypt:kCCEncrypt DESKEY:KEY]]}mutableCopy]
                            file:nil
                         success:^(id data) {
                             if([[NSString stringWithFormat:@"%@",data[@"success"]] isEqualToString:@"1"]){
                                 NSDictionary *dict = data[@"data"];
                                 UserModel *user = [[UserModel alloc]initWithJSONDic:dict];
                                 user.pwd = _password.text;
                                 [Commtion shareCommtion].user = user;
                                 [SVProgressHUD showInfoWithStatus:data[@"message"]];
                                 MainViewController *main = [MainViewController shareManager];
                                 baseNavigationCtrl *navigation = [[baseNavigationCtrl alloc]initWithRootViewController:main];
                                 navigation.navigationBar.hidden = YES;
                                 navigation.delegate = self;
                                 [UIApplication sharedApplication].keyWindow.rootViewController = navigation;
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
        [SVProgressHUD showErrorWithStatus:@"请输入完整的账号密码"];
    }
}

- (IBAction)weiboLogin:(UIButton *)sender {
    
}

- (IBAction)qqLogin:(UIButton *)sender {
    
}

- (IBAction)wCharLogin:(UIButton *)sender {
    
}

- (IBAction)forgetPassword:(UIButton *)sender {
    isOpenHandViewController *openHand = [[isOpenHandViewController alloc]init];
    [self.navigationController pushViewController:openHand animated:YES];
}

#pragma UINavigetionDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    if (navigationController.viewControllers.count == 1) {
        navigationController.navigationBar.hidden = YES;
    }
    else
    {
        navigationController.navigationBar.hidden = NO;
    }
    
    return nil;
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
