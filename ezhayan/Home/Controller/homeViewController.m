//
//  homeViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 15/10/21.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "homeViewController.h"
#import "doThingsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "homeDownView.h"
#import "myChengJiuViewController.h"
#import "timeLineViewController.h"
#import "shareView.h"
#import "TYAlertController.h"
#import "todayScheduleViewController.h"
#import "settimgViewController.h"

#import "homeDataModel.h"

//#import "UILabel+BezierAnimation.h"

@interface homeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *currentPoint;
@property (weak, nonatomic) IBOutlet UILabel *lastTime;
@property (weak, nonatomic) IBOutlet UILabel *doingThings;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *signName;
@property (weak, nonatomic) IBOutlet UIImageView *zhizhen;
@property (weak, nonatomic) IBOutlet UIView *noScheduleView;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIButton *successBut;
@property (weak, nonatomic) IBOutlet UIButton *notFinishBut;

@property (nonatomic, strong) UIView *downView;

@property (nonatomic,strong) homeDataModel *homeData;

@end

@implementation homeViewController

#pragma mark - life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = appBackColor;
//    [self setTitle:@"主页"];
    self.navigationItem.title = @"主页";
    
    _headImage.layer.cornerRadius = 45.0f;
    _headImage.layer.masksToBounds = YES;
    
    UIBarButtonItem *rightBut = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"home1.nav_top_ico1"] style:UIBarButtonItemStylePlain target:self action:@selector(didRightBut:)];
    self.navigationItem.rightBarButtonItem = rightBut;
    
//    CGRect oldframe = _zhizhen.frame;
//    CGPoint anchorPoint = CGPointMake(0.5, 1);
//    _zhizhen.layer.anchorPoint = anchorPoint;
//    _zhizhen.frame = oldframe;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_headImage setImageWithURL:[NSURL URLWithString:[Commtion shareCommtion].user.head_url]];
    _nickName.text = [Commtion shareCommtion].user.nick_name;
    _signName.text = [Commtion shareCommtion].user.personal_sign;
    [self getHomeData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    [_currentPoint animationFromnum:0 toNum:50 duration:3];
}



#pragma mark - getHomedata

- (void)getHomeData
{
    [WXDataServer requestURL:@"UserEvent/getHomeData"
                  httpMethod:@"GET"
                      params:[@{@"md5getHomeData":[UIUtils encodeToPercentEscapeString:[UIUtils TripleDES:[NSString stringWithFormat:@"%@",[Commtion shareCommtion].user.client_id] encryptOrDecrypt:kCCEncrypt DESKEY:KEY]]} mutableCopy]
                        file:nil
                     success:^(id data) {
                         if([[NSString stringWithFormat:@"%@",data[@"success"]] isEqualToString:@"1"]){
                             _noScheduleView.hidden = YES;
                             NSDictionary *dict = data[@"data"];
                             self.homeData = [[homeDataModel alloc]initWithJSONDic:dict];
                             
                         }else {
                             _noScheduleView.hidden = NO;
                         }
                         
                     }
                        fail:^(NSError *error) {
                            [SVProgressHUD showErrorWithStatus:@"链接错误"];
                        }];
}

#pragma mark - setData

- (void)setHomeData:(homeDataModel *)homeData
{
    _homeData = homeData;
    [self setAnchorPoint:CGPointMake(0.5, 1) forView:_zhizhen];
    
    CGFloat point = [homeData.percent floatValue] / 100;
    
    CGFloat angel = (180 * point) - 90;
    
    _zhizhen.transform = CGAffineTransformMakeRotation(-90 * (M_PI / 180.0f));
    
    [UIView animateWithDuration:3 animations:^{
        _zhizhen.transform = CGAffineTransformMakeRotation(angel * (M_PI / 180.0f));
    }];
    
    
    _currentPoint.text = [NSString stringWithFormat:@"%@%%",homeData.percent];
    
    _lastTime.text = homeData.time;
    _doingThings.text = [NSString stringWithFormat:@"当前活动：%@",homeData.name];
    [_successBut setTitle:[NSString stringWithFormat:@"已完成%@项",homeData.FisNum] forState:0];
    [_notFinishBut setTitle:[NSString stringWithFormat:@"未完成%@项",homeData.noFisNum] forState:0];
    
}

- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = view.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    
    CGPoint center = view.center;
    view.center = CGPointMake (center.x - transition.x, center.y - transition.y);
//    NSLog(@"%@",NSStringFromCGPoint(view.center));
}

#pragma mark - eventAction
- (void)didRightBut:(UIBarButtonItem *)sender
{
    [self.navigationController.view addSubview:self.downView];
    [UIView animateWithDuration:0.3 animations:^{
        UIView *headView = [self.downView viewWithTag:100];
        headView.frame = CGRectMake(0, 10, kDeviceWidth, 216);
        self.downView.alpha = 0.9;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            UIView *headView = [self.downView viewWithTag:100];
            headView.frame = CGRectMake(0, 0, kDeviceWidth, 216);
        }];
    }];
}

- (IBAction)seeSchedule:(UIButton *)sender {
    todayScheduleViewController *todaySchedule = [[todayScheduleViewController alloc]init];
    todaySchedule.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:todaySchedule animated:YES];
}

- (IBAction)didThings:(UIButton *)sender {
    doThingsViewController *doting = [[doThingsViewController alloc]init];
    doting.hidesBottomBarWhenPushed = YES;
    doting.title = @"已完成";
    [self.navigationController pushViewController:doting animated:YES];
}

- (IBAction)todoThings:(UIButton *)sender {
}

- (IBAction)setting:(UIButton *)sender {
}

- (IBAction)addSchedule:(UIButton *)sender {
    self.tabBarController.selectedIndex = 3;
}

#pragma mark - getting
- (UIView *)downView
{
    if (_downView == nil) {
        _downView = [[UIView alloc]initWithFrame:self.view.frame];
        _downView.backgroundColor = [UIColor blackColor];
        _downView.alpha = 0;
        
        homeDownView *headView = [[[NSBundle mainBundle] loadNibNamed:@"homeDownView" owner:self options:nil] lastObject];
//        __weak UIView *weakDownView = _downView;
        __weak typeof(self) weakSelf = self;
        headView.didTimeLine = ^{
            [weakSelf.downView removeFromSuperview];
            timeLineViewController *timeline = [[timeLineViewController alloc]init];
            timeline.hidesBottomBarWhenPushed = YES;
            timeline.title = @"时间统计";
            [weakSelf.navigationController pushViewController:timeline animated:YES];
        };
        
        headView.didMeChengJiu = ^{
            [weakSelf.downView removeFromSuperview];
            myChengJiuViewController *chengJiu = [[myChengJiuViewController alloc]init];
            chengJiu.hidesBottomBarWhenPushed = YES;
            chengJiu.title = @"我的成就";
            [weakSelf.navigationController pushViewController:chengJiu animated:YES];
        };
        
        headView.didSetting = ^{
            [weakSelf.downView removeFromSuperview];
            settimgViewController *settimg = [[settimgViewController alloc]init];
            settimg.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:settimg animated:YES];
        };
        
        headView.didToFirends = ^{
            [weakSelf.downView removeFromSuperview];
            shareView *share = [[[NSBundle mainBundle] loadNibNamed:@"shareView" owner:self options:nil] lastObject];
            CGRect frame = share.frame;
            frame.size.width = kDeviceWidth - 40;
            share.frame = frame;
            TYAlertController *alertCtrl = [TYAlertController alertControllerWithAlertView:share preferredStyle:TYAlertControllerStyleAlert];
            alertCtrl.backgoundTapDismissEnable = YES;
            [weakSelf presentViewController:alertCtrl animated:YES completion:nil];
        };
        headView.tag = 100;
        headView.frame = CGRectMake(0, -216, kDeviceWidth, 216);
        [_downView addSubview:headView];
        
    }
    return _downView;
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
