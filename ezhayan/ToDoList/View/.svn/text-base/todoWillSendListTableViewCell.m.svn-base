//
//  todoWillSendListTableViewCell.m
//  ezhayan
//
//  Created by ChenFengbo on 16/2/22.
//  Copyright © 2016年 ChenFengbo. All rights reserved.
//

#import "todoWillSendListTableViewCell.h"

@interface todoWillSendListTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;

@end

@implementation todoWillSendListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(todoWilldoListModel *)model
{
    _model = model;
    _fromLabel.text = [NSString stringWithFormat:@"来自：%@",model.clientName];
    _name.text = model.name;
}

@end
