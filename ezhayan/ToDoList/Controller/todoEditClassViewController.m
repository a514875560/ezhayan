//
//  todoEditClassViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 16/2/24.
//  Copyright © 2016年 ChenFengbo. All rights reserved.
//

#import "todoEditClassViewController.h"

NSString *const kTodoClassName = @"todoClassName";
NSString *const kClassDescription = @"ClassDescription";
NSString *const kClassBgImage = @"ClassBgImage";
NSString *const kDeleteClass = @"DeleteClass";

@interface todoEditClassViewController ()

@end

@implementation todoEditClassViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeForm];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initializeForm];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"编辑分类";
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
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    
    // Title
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kTodoClassName rowType:XLFormRowDescriptorTypeText title:@"名  称："];
    [section addFormRow:row];
    
    // description
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kClassDescription rowType:XLFormRowDescriptorTypeTextView title:@"描述："];
    [section addFormRow:row];
    
    // image
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kClassBgImage rowType:XLFormRowDescriptorTypeButton title:@"设置封面图："];
    [row.cellConfig setObject:@(NSTextAlignmentLeft) forKey:@"textLabel.textAlignment"];
    [row.cellConfig setObject:[UIUtils colorWithHexString:@"#000000"] forKey:@"textLabel.textColor"];
    [row.cellConfig setObject:[UIFont systemFontOfSize:15] forKey:@"textLabel.font"];
    [section addFormRow:row];
    
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    
    // Notes
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kDeleteClass rowType:XLFormRowDescriptorTypeButton title:@"删除该分类"];
    [row.cellConfig setObject:@(NSTextAlignmentCenter) forKey:@"textLabel.textAlignment"];
    [row.cellConfig setObject:[UIUtils colorWithHexString:@"#000000"] forKey:@"textLabel.textColor"];
    [row.cellConfig setObject:[UIFont systemFontOfSize:15] forKey:@"textLabel.font"];
    row.action.formSelector = @selector(deleteClassBut);
    [section addFormRow:row];
    
    self.form = form;
}

#pragma mark - didEvent

- (void)deleteClassBut
{
    
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
