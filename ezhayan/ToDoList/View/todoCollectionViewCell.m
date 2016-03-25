//
//  todoCollectionViewCell.m
//  ezhayan
//
//  Created by ChenFengbo on 15/10/28.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "todoCollectionViewCell.h"

@interface todoCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *toDoNum;

@end

@implementation todoCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(todoClassListModel *)model
{
    _model = model;
    _name.text = model.name;
    [_img setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    _toDoNum.text = [NSString stringWithFormat:@"共%@项活动",model.count];
}

- (IBAction)didEdit:(UIButton *)sender {
    _didEdit();
}

@end
