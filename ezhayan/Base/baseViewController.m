//
//  baseViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 15/10/21.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "baseViewController.h"
#import "UIView+firstResponder.h"

@interface baseViewController ()

@property (nonatomic,strong) UITapGestureRecognizer *tap;


@end

@implementation baseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:appNavbarBgColor];//[UIColor colorWithPatternImage:[UIImage imageNamed:@"nav_bgcolor"]]

    self.view.backgroundColor = [UIColor whiteColor];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    
    //监听键盘弹出事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //监听键盘隐藏事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView:)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - 在dealloc中移除所有关注的通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 键盘即将弹出事件处理
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *keyBoardInfo = notification.userInfo;
    UIView *firstResponder = [self.view firstResponder];
    
    if(firstResponder){
        CGRect frame = firstResponder.frame;
        if(firstResponder.superview != self.view){
            frame = [firstResponder convertRect:frame toView:self.view];
        }
        CGFloat viewY = CGRectGetMaxY(frame);
        CGFloat keyBoardY = [keyBoardInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue].origin.y;
        CGFloat delta = keyBoardY - viewY;
        if(delta < 0){
            [UIView animateWithDuration:0.5 animations:^{
                self.view.transform = CGAffineTransformMakeTranslation(0, delta);
            } completion:nil];
        }
    }
    [self.view addGestureRecognizer:_tap];
}

#pragma mark - 键盘即将隐藏事件
- (void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:nil];
    [self.view removeGestureRecognizer:_tap];
}

#pragma mark - 点击屏幕关闭键盘
- (void)didTapView:(UITapGestureRecognizer *)tapGesture
{
    [self.view endEditing:YES];
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
