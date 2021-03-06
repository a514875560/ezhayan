//
//  AppDelegate.m
//  ezhayan
//
//  Created by ChenFengbo on 15/10/21.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "Commtion.h"
#import "loginViewController.h"
#import "baseNavigationCtrl.h"


@interface AppDelegate ()<UINavigationControllerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_window makeKeyAndVisible];
    
    
    if (![[Commtion shareCommtion] isLogin]) {
        loginViewController *login = [[loginViewController alloc]init];
        baseNavigationCtrl *navigation = [[baseNavigationCtrl alloc]initWithRootViewController:login];
        _window.rootViewController = navigation;
    }
    else
    {
        [self autoLogin];
        MainViewController *main = [MainViewController shareManager];
        baseNavigationCtrl *navigation = [[baseNavigationCtrl alloc]initWithRootViewController:main];
        navigation.navigationBar.hidden = YES;
        navigation.delegate = self;
        _window.rootViewController = navigation;
    }
    
    return YES;
}

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

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - actionEvent
- (void)autoLogin
{
    UserModel *Olduser = [Commtion shareCommtion].user;
    [WXDataServer requestURL:@"UserEvent/login"
                  httpMethod:@"GET"
                      params:[@{@"md5login":[UIUtils encodeToPercentEscapeString:[UIUtils TripleDES:[NSString stringWithFormat:@"%@:%@", Olduser.tel,Olduser.pwd] encryptOrDecrypt:kCCEncrypt DESKEY:KEY]]}mutableCopy]
                        file:nil
                     success:^(id data) {
                         if([[NSString stringWithFormat:@"%@",data[@"success"]] isEqualToString:@"1"]){
                             NSDictionary *dict = data[@"data"];
                             UserModel *user = [[UserModel alloc]initWithJSONDic:dict];
                             user.pwd = Olduser.pwd;
                             [Commtion shareCommtion].user = user;
                             
                             
                         }
                         else
                         {
                             loginViewController *login = [[loginViewController alloc]init];
                             baseNavigationCtrl *navigation = [[baseNavigationCtrl alloc]initWithRootViewController:login];
                             _window.rootViewController = navigation;
                         }
                     }
                        fail:^(NSError *error) {
                            [[Commtion shareCommtion] resetUser];
                            loginViewController *login = [[loginViewController alloc]init];
                            baseNavigationCtrl *navigation = [[baseNavigationCtrl alloc]initWithRootViewController:login];
                            _window.rootViewController = navigation;
                    }];
}

@end
