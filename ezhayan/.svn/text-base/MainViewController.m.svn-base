//
//  MainViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 15/10/21.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "MainViewController.h"
#import "homeViewController.h"
#import "targetViewController.h"
#import "toDoListViewController.h"
#import "threeScheduleViewCtrl.h"
#import "friendsViewController.h"
#import "WXItemView.h"
#import "baseNavigationCtrl.h"

@interface MainViewController ()<WXItemViewDelegate>
{
    NSMutableArray *_tabbars;
}

@end

@implementation MainViewController

+ (instancetype)shareManager
{
    static MainViewController *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tabbars = [NSMutableArray array];
    
    [self loadTabbarViewContorllers];
//    [self createTabbar];
    self.tabBar.tintColor = appTabbarColor;
    self.tabBar.backgroundImage = [self buttonImageFromColor:appTabbarBgColor];
    
}

- (UIImage *)buttonImageFromColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0, 0, kDeviceWidth, 49);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); return img;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadTabbarViewContorllers
{
    homeViewController *home = [[homeViewController alloc]init];
    [home.tabBarItem setTitle:@"我的"];
    [home.tabBarItem setImage:[[UIImage imageNamed:@"home.1_nav_icon1n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [home.tabBarItem setSelectedImage:[[UIImage imageNamed:@"home.1_nav_icon1h"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]];
    
    targetViewController *target = [[targetViewController alloc]init];
    [target.tabBarItem setTitle:@"目标"];
    [target.tabBarItem setImage:[[UIImage imageNamed:@"home.1_nav_icon2n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [target.tabBarItem setSelectedImage:[[UIImage imageNamed:@"home.1_nav_icon2h"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    toDoListViewController *toDoList = [[toDoListViewController alloc]init];
    [toDoList.tabBarItem setTitle:@"待办"];
    [toDoList.tabBarItem setImage:[[UIImage imageNamed:@"home.1_nav_icon3n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [toDoList.tabBarItem setSelectedImage:[[UIImage imageNamed:@"home.1_nav_icon3h"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    threeScheduleViewCtrl *schedule = [[threeScheduleViewCtrl alloc]init];
    [schedule.tabBarItem setTitle:@"日程"];
    [schedule.tabBarItem setImage:[[UIImage imageNamed:@"home.1_nav_icon4n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [schedule.tabBarItem setSelectedImage:[[UIImage imageNamed:@"home.1_nav_icon4h"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    friendsViewController *friends = [[friendsViewController alloc]init];
    [friends.tabBarItem setTitle:@"朋友"];
    [friends.tabBarItem setImage:[[UIImage imageNamed:@"home.1_nav_icon5n"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [friends.tabBarItem setSelectedImage:[[UIImage imageNamed:@"home.1_nav_icon5h"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //加入数组
    NSArray *VCs = @[home, target, toDoList, schedule, friends];
    
    //创建导航栏控制器
    NSMutableArray *navVCs = [NSMutableArray arrayWithCapacity:VCs.count];
    for (baseViewController *vc in VCs) {
        baseNavigationCtrl *navVC = [[baseNavigationCtrl alloc] initWithRootViewController:vc];
        [navVCs addObject:navVC];
    }
    self.viewControllers = navVCs;
}

- (void)createTabbar
{
    
    self.tabBar.backgroundImage = [self buttonImageFromColor:appTabbarBgColor];
    
    //个数
    NSInteger count = [self.viewControllers count];
    
    //每个item宽度
    CGFloat itemWidth = kDeviceWidth / count;
    // 存放图片名称
    NSArray *images = @[@"home.1_nav_icon1n", @"home.1_nav_icon2n", @"home.1_nav_icon3n", @"home.1_nav_icon4n", @"home.1_nav_icon5n"];
    NSArray *selectImages = @[@"home.1_nav_icon1h", @"home.1_nav_icon2h", @"home.1_nav_icon3h", @"home.1_nav_icon4h", @"home.1_nav_icon5h"];
    NSArray *titles = @[@"我的", @"目标", @"待办", @"日程", @"朋友"];

    //自定义button
    for (int i = 0; i < count; i++) {
        NSString *imgNamed = images[i];
        NSString *selectNamed = selectImages[i];
        NSString *title = titles[i];
        WXItemView *wxItemView = [[WXItemView alloc] initWithFrame:CGRectMake(itemWidth*i, -5, itemWidth, 54)];
        [wxItemView.itemButton setImage:[UIImage imageNamed:imgNamed] forState:0];
        [wxItemView.itemButton setImage:[UIImage imageNamed:selectNamed] forState:UIControlStateSelected];
        wxItemView.itemButton.contentMode = UIViewContentModeScaleAspectFit;
        wxItemView.itemButton.tag = i;
        //设置代理
        wxItemView.delegate = self;
//      wxItemView.tag = i + 100;
    
        wxItemView.textLable.text = title;
        [self.tabBar addSubview:wxItemView];
        if (i == 0) {
            wxItemView.itemButton.selected = YES;
            wxItemView.textLable.textColor = appTabbarColor;
        }
        [_tabbars addObject:wxItemView];
    }
}

#pragma mark - WXItemView Delegate

- (void)didSelectItemViewWithIndex:(NSInteger)index
{
    self.selectedIndex = index;
    for (int i = 0; i < _tabbars.count; i++) {
        WXItemView *item = _tabbars[i];
        if (i == index) {
            item.itemButton.selected = YES;
            item.textLable.textColor = appTabbarColor;
        }
        else
        {
            item.itemButton.selected = NO;
            item.textLable.textColor = [UIColor whiteColor];
        }
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
