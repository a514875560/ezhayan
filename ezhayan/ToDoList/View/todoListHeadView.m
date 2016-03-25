//
//  todoListHeadView.m
//  ezhayan
//
//  Created by ChenFengbo on 15/10/28.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "todoListHeadView.h"

@interface todoListHeadView ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImg;
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *nickName;

@end

@implementation todoListHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _headImg.layer.cornerRadius = 36.0f;
    _headImg.layer.masksToBounds = YES;
    
    [_headImg setImageWithURL:[NSURL URLWithString:[Commtion shareCommtion].user.head_url] placeholderImage:[UIImage imageNamed:@"home.1_content_bg01"]];
    _nickName.text = [Commtion shareCommtion].user.nick_name;
    [self.contentView removeFromSuperview];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (IBAction)didNewToDo:(UIButton *)sender {
    _didAddNewTodo();
}

@end
