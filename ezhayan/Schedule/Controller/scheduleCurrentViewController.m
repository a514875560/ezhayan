//
//  scheduleCurrentViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 16/2/24.
//  Copyright © 2016年 ChenFengbo. All rights reserved.
//

#import "scheduleCurrentViewController.h"
#import "scheduleHomeHeadView.h"

#define headViewHeight(x) x * 298 / 375

@interface scheduleCurrentViewController ()

@property (nonatomic,strong) scheduleHomeHeadView *headView;
@property (nonatomic,strong) UIView *footView;

@end

@implementation scheduleCurrentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = appTableviewBgColor;
    NSDate *senddate = [NSDate date];
    
    NSDateFormatter  *dateformatter = [[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"MM月dd日 yyyy"];
    
    NSString *locationString = [dateformatter stringFromDate:senddate];
    self.navigationItem.title = locationString;
    
    [self.view addSubview:self.headView];
    [self.view addSubview:self.footView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -getter

- (scheduleHomeHeadView *)headView
{
    if (_headView == nil) {
        _headView = [[[NSBundle mainBundle] loadNibNamed:@"scheduleHomeHeadView" owner:self options:nil] lastObject];
        _headView.frame = CGRectMake(0, 64, kDeviceWidth, headViewHeight(kDeviceWidth) + 64);
        
    }
    return _headView;
}

- (UIView *)footView
{
    if (_footView == nil) {
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, self.headView.bottom, kDeviceWidth, 80)];
        _footView.backgroundColor = [UIUtils colorWithHexString:@"#ebebeb"];
        
        UILabel *remarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, kDeviceWidth - 30, 60)];
        remarkLabel.text = @"你是我的小苹果你是我的小苹果你是我的小苹果你是我的小苹果你是我的小苹果你是我的小苹果你是我的小苹果";
        remarkLabel.numberOfLines = 0;
        remarkLabel.textColor = [UIUtils colorWithHexString:@"#333333"];
        remarkLabel.font = [UIFont systemFontOfSize:13];
        [_footView addSubview:remarkLabel];
    }
    return _footView;
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
