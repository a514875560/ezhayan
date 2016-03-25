//
//  headImageCell.m
//  ezhayan
//
//  Created by ChenFengbo on 16/2/25.
//  Copyright © 2016年 ChenFengbo. All rights reserved.
//

#import "headImageCell.h"

NSString * const XLFormRowDescriptorTypeImage = @"XLFormRowDescriptorTypeImage";

@implementation headImageCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (void)load
{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([headImageCell class]) forKey:XLFormRowDescriptorTypeImage];
}

- (void)configure
{
    [super configure];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)update
{
    [super update];
    
    self.image.image = self.rowDescriptor.value;
    self.titleLabel.text = self.rowDescriptor.title;
    
    
//    [self.ratingView setAlpha:((self.rowDescriptor.isDisabled) ? .6 : 1)];
//    [self.rateTitle setAlpha:((self.rowDescriptor.isDisabled) ? .6 : 1)];
}

+ (CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor
{
    return 51;
}

-(BOOL)formDescriptorCellCanBecomeFirstResponder
{
    return !self.rowDescriptor.isDisabled;
}

-(BOOL)formDescriptorCellBecomeFirstResponder
{
    return YES;
}

- (void)formDescriptorCellDidSelectedWithFormController:(XLFormViewController *)controller
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [controller presentViewController:picker animated:YES completion:^{
            
        }];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [controller presentViewController:picker animated:YES completion:^{
            
        }];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [controller presentViewController:alert animated:YES completion:^{
        
    }];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    
    self.rowDescriptor.value = image;
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}




@end
