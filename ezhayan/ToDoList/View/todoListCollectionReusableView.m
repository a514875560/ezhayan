//
//  todoListCollectionReusableView.m
//  ezhayan
//
//  Created by ChenFengbo on 15/11/6.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "todoListCollectionReusableView.h"

@interface todoListCollectionReusableView ()
@property (weak, nonatomic) IBOutlet UIButton *willDoBut;
@property (weak, nonatomic) IBOutlet UIButton *didFinshBut;
@property (weak, nonatomic) IBOutlet UIButton *willSendBut;
@property (weak, nonatomic) IBOutlet UIButton *didSendBut;

@property (weak, nonatomic) IBOutlet UILabel *willDo;
@property (weak, nonatomic) IBOutlet UILabel *didFinsh;
@property (weak, nonatomic) IBOutlet UILabel *willSend;
@property (weak, nonatomic) IBOutlet UILabel *didSend;

@end

@implementation todoListCollectionReusableView

- (void)awakeFromNib {
    // Initialization code
    _willDoBut.layer.borderWidth = 0.5;
    _willDoBut.layer.borderColor = [UIUtils colorWithHexString:@"#aaaaaa"].CGColor;
    _didFinshBut.layer.borderWidth = 0.5;
    _didFinshBut.layer.borderColor = [UIUtils colorWithHexString:@"#aaaaaa"].CGColor;
    _willSendBut.layer.borderWidth = 0.5;
    _willSendBut.layer.borderColor = [UIUtils colorWithHexString:@"#aaaaaa"].CGColor;
    _didSendBut.layer.borderWidth = 0.5;
    _didSendBut.layer.borderColor = [UIUtils colorWithHexString:@"#aaaaaa"].CGColor;
    
    _willDoBut.backgroundColor = [UIUtils colorWithHexString:@"#f2f2f2"];
}

- (void)setModel:(todoHomeListModel *)model
{
    _model = model;
    _willDo.text = [NSString stringWithFormat:@"%ld",model.noFisListCount];
    _didFinsh.text = [NSString stringWithFormat:@"%ld",model.fisListCount];
    _willSend.text = [NSString stringWithFormat:@"%ld",model.noSendListCount];
    _didSend.text = [NSString stringWithFormat:@"%ld",model.sendListCount];
}

- (IBAction)willDo:(UIButton *)sender {
    _willDoBut.backgroundColor = [UIUtils colorWithHexString:@"#f2f2f2"];
    _didFinshBut.backgroundColor = [UIColor clearColor];
    _didSendBut.backgroundColor = [UIColor clearColor];
    _willSendBut.backgroundColor = [UIColor clearColor];
    _didWillDo();
}

- (IBAction)didFinsh:(UIButton *)sender {
    _willDoBut.backgroundColor = [UIColor clearColor];
    _didFinshBut.backgroundColor = [UIUtils colorWithHexString:@"#f2f2f2"];
    _didSendBut.backgroundColor = [UIColor clearColor];
    _willSendBut.backgroundColor = [UIColor clearColor];
    _didFinshDo();
}

- (IBAction)willSend:(UIButton *)sender {
    _willDoBut.backgroundColor = [UIColor clearColor];
    _didFinshBut.backgroundColor = [UIColor clearColor];
    _didSendBut.backgroundColor = [UIColor clearColor];
    _willSendBut.backgroundColor = [UIUtils colorWithHexString:@"#f2f2f2"];
    _didWillSend();
}

- (IBAction)didSend:(UIButton *)sender {
    _willDoBut.backgroundColor = [UIColor clearColor];
    _didFinshBut.backgroundColor = [UIColor clearColor];
    _didSendBut.backgroundColor = [UIUtils colorWithHexString:@"#f2f2f2"];
    _willSendBut.backgroundColor = [UIColor clearColor];
    _didFinshSend();
}

@end
