//
//  targetNewTargetViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 16/2/17.
//  Copyright © 2016年 ChenFengbo. All rights reserved.
//

#import "EZYtargetNewTargetViewController.h"

NSString *const kNewName = @"name";
NSString *const kNewDoWhat = @"doWhat";
NSString *const kNewHowTodo = @"howTodo";
NSString *const kNewRemarks = @"remarks";

@interface EZYtargetNewTargetViewController ()

@end

@implementation EZYtargetNewTargetViewController

- (instancetype)init
{
    self = [super init];
    if (self ) {
        [self initializeForm];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeForm];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initForm
- (void)initializeForm
{
    XLFormDescriptor * form;
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    form = [XLFormDescriptor formDescriptor];
    section = [XLFormSectionDescriptor formSectionWithTitle:@"目标名称"];
    [form addFormSection:section];
    
    // Title
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kNewName rowType:XLFormRowDescriptorTypeText title:@"名  称"];
    [row.cellConfigAtConfigure setObject:@"输入名称" forKey:@"textField.placeholder"];
    row.required = YES;
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"做什么"];
    [form addFormSection:section];
    
    // Title
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kNewDoWhat rowType:XLFormRowDescriptorTypeText title:@"目标详情"];
    [row.cellConfigAtConfigure setObject:@"输入描述" forKey:@"textField.placeholder"];
    row.required = YES;
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"怎么做"];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kNewHowTodo rowType:XLFormRowDescriptorTypeTextView title:@"达成方法"];
    row.required = YES;
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"备注"];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kNewRemarks rowType:XLFormRowDescriptorTypeTextView title:@"附加信息"];
    row.required = YES;
    [section addFormRow:row];
    
    self.form = form;
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
