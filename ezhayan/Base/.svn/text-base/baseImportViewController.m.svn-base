//
//  baseImportViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 15/11/12.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "baseImportViewController.h"

@interface baseImportViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation baseImportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(didRightBut:)];
    self.navigationItem.rightBarButtonItem = right;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)setTitle:(NSString *)title
//{
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
//    titleLabel.text = title;
//    titleLabel.font = [UIFont boldSystemFontOfSize:22];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.textColor = [UIColor whiteColor];
//    self.navigationItem.titleView = titleLabel;
//}

#pragma mark - actionEvent
- (void)didRightBut:(UIBarButtonItem *)sender
{
    _didSuccess (_name,_textView.text);
    [self.navigationController popViewControllerAnimated:YES];
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
