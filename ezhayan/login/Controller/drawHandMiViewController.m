//
//  drawHandMiViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 15/11/13.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "drawHandMiViewController.h"
#import "LockView.h"

@interface drawHandMiViewController ()<LockViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *text;
@property (nonatomic, strong) LockView *lockview;
@property (weak, nonatomic) IBOutlet UILabel *errerText;

//标记是否是重置密码
@property(nonatomic ,assign,getter=isresetpassword)BOOL resetpassword;
//判断是否是两次确认密码
@property(nonatomic,assign,getter=istwopassword)BOOL twopassword;

@end

@implementation drawHandMiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"passwordone"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"passwordtwo"];
    [self.view addSubview:self.lockview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LockViewDelegate
- (BOOL)unlockView:(LockView *)unlockView withPassword:(NSString *)password
{
    NSString *localpasswordone = [[NSUserDefaults standardUserDefaults]objectForKey:@"passwordone"];
    NSString *localpasswordtwo = [[NSUserDefaults standardUserDefaults]objectForKey:@"passwordtwo"];
    
    if (self.twopassword) {
        if ([localpasswordone isEqualToString:localpasswordtwo]) {
            //            UIAlertView *confirmalertview = [[UIAlertView alloc]initWithTitle:@"密码设置成功" message:@"请输入密码解锁" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            //            [confirmalertview show];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密码设置成功" message:@"请输入密码解锁" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alert animated:YES completion:nil];
            self.text.text = @"验证手势密码";
            self.errerText.text = @"";
            self.twopassword = NO;
            return YES;
        }
        else
        {
//            UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"与上次密码不对应" message:@"请重新设置密码" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
//            [alertview show];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"passwordone"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"passwordtwo"];
            self.text.text = @"请绘制手势密码";
            self.errerText.text = @"与上次密码不匹配，请重新设置密码";
            return NO;
        }
    }
    else
    {
        if ([password isEqualToString:localpasswordone]) {
            if (self.isresetpassword) {
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"passwordone"];
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"passwordtwo"];
                self.text.text = @"设置新密码";
                self.errerText.text = @"";
//                UIAlertView *resetalertview = [[UIAlertView alloc]initWithTitle:@"密码确认成功" message:@"请重新设置密码" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
//                [resetalertview show];
                self.resetpassword = NO;
            }
            else
            {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            return YES;
        }
        else
        {
            return NO;
        }
        return NO;
    }
}

- (void)setPassWordSuccess:(NSString *)tabelname
{
    NSString *localpasswordone = [[NSUserDefaults standardUserDefaults]objectForKey:@"passwordone"];
    NSString *localpasswordtwo = [[NSUserDefaults standardUserDefaults]objectForKey:@"passwordywo"];
    if (!localpasswordtwo||!localpasswordone ) {
        self.twopassword = YES;
    }
    self.text.text = tabelname;
    self.errerText.text = @"";
}

#pragma mark - getter
- (LockView *)lockview
{
    if (_lockview == nil) {
        _lockview = [[LockView alloc]init];
        _lockview.backgroundColor = [UIColor clearColor];
        _lockview.width = 300;
        _lockview.height = 300;
        _lockview.left = (kDeviceWidth - _lockview.width) * 0.5;
        _lockview.top = 160;
        _lockview.delegate = self;
    }
    return _lockview;
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
