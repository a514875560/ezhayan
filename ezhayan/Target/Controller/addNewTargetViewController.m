//
//  addNewTargetViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 15/10/27.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "addNewTargetViewController.h"
//#import "addTargetView.h"
//#import "addScheduleView.h"

#import "EZYtargetNewTargetViewController.h"
#import "EZYtargetNewScheduleViewController.h"

@interface addNewTargetViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UISegmentedControl *segmented;
@property (nonatomic, strong) UIScrollView *scrollView;
//@property (nonatomic, strong) UIScrollView *addTarget;
//@property (nonatomic, strong) UIScrollView *addSchedule;

@property (nonatomic,strong) EZYtargetNewTargetViewController *addTargetCtrl;
@property (nonatomic,strong) EZYtargetNewScheduleViewController *addScheduleCtrl;

@property (nonatomic, assign) BOOL isNewTarget;

@end

@implementation addNewTargetViewController

#pragma mark - life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"新建"];
    _isNewTarget = YES;
    self.view.backgroundColor = appTableviewBgColor;
    
    [self.view addSubview:self.segmented];
    
    [self.view addSubview:self.scrollView];
    
//    [self.scrollView addSubview:self.addTarget];
//    [self.scrollView addSubview:self.addSchedule];
    [self.scrollView addSubview:self.addTargetCtrl.view];
    [self.scrollView addSubview:self.addScheduleCtrl.view];
    [self addChildViewController:self.addTargetCtrl];
    [self addChildViewController:self.addScheduleCtrl];
    
    UIBarButtonItem *rightBut = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(didRightBut:)];
    self.navigationItem.rightBarButtonItem = rightBut;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - didEvent
- (void)segmentChange:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:
            _isNewTarget = YES;
            [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            break;
            
        default:
            _isNewTarget = NO;
            [_scrollView setContentOffset:CGPointMake(kDeviceWidth, 0) animated:YES];
            break;
    }
}

- (void)didRightBut:(UIBarButtonItem *)sender
{
    if (_isNewTarget) {
        NSArray * validationErrors = [self.addTargetCtrl formValidationErrors];
        if (validationErrors.count > 0){
            [self.addTargetCtrl showFormValidationError:[validationErrors firstObject]];
            return;
        }
        [self.addTargetCtrl.tableView endEditing:YES];
        
        NSDictionary *dict = self.addTargetCtrl.form.formValues;
        [SVProgressHUD show];
        [WXDataServer requestURL:@"ObjectiveEvent/saveObjective"
                      httpMethod:@"GET"
                          params:[@{@"md5saveObjective":[UIUtils encodeToPercentEscapeString:[UIUtils TripleDES:[NSString stringWithFormat:@"%@", [Commtion shareCommtion].user.client_id] encryptOrDecrypt:kCCEncrypt DESKEY:KEY]],
                                    @"parent_objective_id":self.objId,
                                    @"name":dict[@"name"],
                                    @"description":dict[@"doWhat"],
                                    @"review":dict[@"howTodo"],
                                    @"summary":dict[@"remarks"]}mutableCopy]
                            file:nil
                         success:^(id data) {
                             if([[NSString stringWithFormat:@"%@",data[@"success"]] isEqualToString:@"1"]){
                                 
                                 [SVProgressHUD showSuccessWithStatus:data[@"message"]];
                                 [self.navigationController popViewControllerAnimated:YES];
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
        NSArray * validationErrors = [self.addScheduleCtrl formValidationErrors];
        if (validationErrors.count > 0){
            [self.addScheduleCtrl showFormValidationError:[validationErrors firstObject]];
            return;
        }
        [self.addScheduleCtrl.tableView endEditing:YES];
        
        NSDictionary *dict = [self.addScheduleCtrl.form httpParameters:self.addScheduleCtrl];
        
        NSDateFormatter *formmatter = [[NSDateFormatter alloc]init];
        [formmatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *starTime = [formmatter stringFromDate:dict[@"scheduleStarTime"]];
        NSString *endTime = [formmatter stringFromDate:dict[@"scheduleEndTime"]];
        
        [SVProgressHUD show];
        [WXDataServer requestURL:@"ScheduleEvent/saveSchedule"
                      httpMethod:@"GET"
                          params:[@{@"md5saveSchedule":[UIUtils encodeToPercentEscapeString:[UIUtils TripleDES:[NSString stringWithFormat:@"%@", [Commtion shareCommtion].user.client_id] encryptOrDecrypt:kCCEncrypt DESKEY:KEY]],
                                    @"objective_id":self.objId,
                                    @"starttime":starTime,
                                    @"overtime":endTime,
                                    @"cycle":dict[@"schedultRepeat"],
                                    @"cycle_over_time":@"",
                                    @"description":dict[@"scheduleRemarks"]}mutableCopy]
                            file:nil
                         success:^(id data) {
                             if([[NSString stringWithFormat:@"%@",data[@"success"]] isEqualToString:@"1"]){
                                 
                                 [SVProgressHUD showSuccessWithStatus:data[@"message"]];
                                 [self.navigationController popViewControllerAnimated:YES];
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
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    if (point.x <= kDeviceWidth/2) {
        _isNewTarget = YES;
        _segmented.selectedSegmentIndex = 0;
    }
    else
    {
        _isNewTarget = NO;
        _segmented.selectedSegmentIndex = 1;
    }
}

#pragma mark - getter
- (UISegmentedControl *)segmented
{
    if (_segmented == nil) {
        _segmented = [[UISegmentedControl alloc]initWithItems:@[@"目标",@"日程"]];
        _segmented.tintColor = [UIUtils colorWithHexString:@"#40b49a"];
        _segmented.selectedSegmentIndex = 0;
        [_segmented addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
        _segmented.frame = CGRectMake(kDeviceWidth / 2 - 87, 85, 174, 38);
    }
    return _segmented;
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _segmented.bottom, kDeviceWidth, KDeviceHeight - _segmented.bottom)];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(kDeviceWidth * 2, KDeviceHeight - _segmented.bottom);
        //    _scrollView.backgroundColor = appTabbarColor;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}

- (EZYtargetNewTargetViewController *)addTargetCtrl
{
    if (_addTargetCtrl == nil) {
        _addTargetCtrl = [[EZYtargetNewTargetViewController alloc]init];
        _addTargetCtrl.view.frame = CGRectMake(0, 10, kDeviceWidth, _scrollView.frame.size.height - 10);
    }
    return _addTargetCtrl;
}

- (EZYtargetNewScheduleViewController *)addScheduleCtrl
{
    if (_addScheduleCtrl == nil) {
        _addScheduleCtrl = [[EZYtargetNewScheduleViewController alloc]init];
        _addScheduleCtrl.objName = self.objName;
        _addScheduleCtrl.view.frame = CGRectMake(kDeviceWidth, 10, kDeviceWidth, _scrollView.frame.size.height - 10);
    }
    return _addScheduleCtrl;
}

//- (UIScrollView *)addTarget
//{
//    if (_addTarget == nil) {
//        _addTarget = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, kDeviceWidth, _scrollView.frame.size.height - 10)];
//        _addTarget.contentSize = CGSizeMake(kDeviceWidth, 514);
//        addTargetView *addTarget = [[[NSBundle mainBundle] loadNibNamed:@"addTargetView" owner:self options:nil] lastObject];
//        addTarget.frame = CGRectMake(0, 0, kDeviceWidth, 514);
//        [_addTarget addSubview:addTarget];
//    }
//    return _addTarget;
//}
//
//- (UIScrollView *)addSchedule
//{
//    if (_addSchedule == nil) {
//        _addSchedule = [[UIScrollView alloc]initWithFrame:CGRectMake(kDeviceWidth, 10, kDeviceWidth, _scrollView.frame.size.height - 10)];
//        _addSchedule.contentSize = CGSizeMake(kDeviceWidth, 514);
//        addScheduleView *addSchedule = [[[NSBundle mainBundle] loadNibNamed:@"addScheduleView" owner:self options:nil] lastObject];
//        addSchedule.frame = CGRectMake(0, 0, kDeviceWidth, 514);
//        [_addSchedule addSubview:addSchedule];
//    }
//    return _addSchedule;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
