//
//  isOpenHandViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 15/11/13.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "isOpenHandViewController.h"
#import "drawHandMiViewController.h"

@interface isOpenHandViewController ()
@property (weak, nonatomic) IBOutlet UIButton *openBut;
@property (weak, nonatomic) IBOutlet UIButton *notOpenBut;

@end

@implementation isOpenHandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _openBut.layer.cornerRadius = 4;
    _openBut.layer.masksToBounds = YES;
    _notOpenBut.layer.cornerRadius = 4;
    _notOpenBut.layer.masksToBounds = YES;
    _notOpenBut.layer.borderWidth = 1;
    _notOpenBut.layer.borderColor = [UIUtils colorWithHexString:@"#40b49c"].CGColor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didOpen:(UIButton *)sender {
    drawHandMiViewController *drawhand = [[drawHandMiViewController alloc]init];
    [self.navigationController pushViewController:drawhand animated:YES];
    
}
- (IBAction)didNotOpen:(UIButton *)sender {
    
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
