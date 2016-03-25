//
//  targetTableViewCell.m
//  ezhayan
//
//  Created by ChenFengbo on 15/10/27.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "targetTableViewCell.h"

@interface targetTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIButton *rightBut;
@property (weak, nonatomic) IBOutlet UIImageView *successImg;

@end

@implementation targetTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _img.layer.cornerRadius = 23;
    _img.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)setModel:(targetListModel *)model
//{
//    self.model = model;
//    self.name.text = model.name;
//    [self.img setImageWithURL:[NSURL URLWithString:model.image]];
//    if (model.oknum.length) {
//        if ([model.oknum integerValue] > 0) {
//            self.content.text = [NSString stringWithFormat:@"(共%@项)",model.oknum];
//            [self.rightBut setImage:[UIImage imageNamed:@"object1_content_right"] forState:UIControlStateNormal];
//        }
//        else
//        {
//            self.content.text = @"(无)";
//            [self.rightBut setImage:[UIImage imageNamed:@"object1_content_jia"] forState:UIControlStateNormal];
//        }
//    }
//    else
//    {
//        self.content.text = @"(无)";
//        [self.rightBut setImage:[UIImage imageNamed:@"object1_content_jia"] forState:UIControlStateNormal];
//    }
//}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.name.text = _model.name;
    [self.img setImageWithURL:[NSURL URLWithString:_model.image]];

    if ([self.model.objnum integerValue]) {
        self.content.text = [NSString stringWithFormat:@" (共%@项,完成%@项)",_model.objnum,_model.oknum];
        [self.rightBut setImage:[UIImage imageNamed:@"object1_content_right"] forState:UIControlStateNormal];
    }
    else if ([self.model.schedulenum integerValue])
    {
        self.content.text = [NSString stringWithFormat:@" (共%@项,完成%@项)",_model.schedulenum,_model.oknum];
        [self.rightBut setImage:[UIImage imageNamed:@"object1_content_right"] forState:UIControlStateNormal];
    }
    else
    {
        self.content.text = @" (无)";
        [self.rightBut setImage:[UIImage imageNamed:@"object1_content_jia"] forState:UIControlStateNormal];
    }
    
    self.successImg.hidden = YES;
}

- (IBAction)didRightBut:(UIButton *)sender {
    
}

@end
