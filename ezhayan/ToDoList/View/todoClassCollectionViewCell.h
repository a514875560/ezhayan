//
//  todoClassCollectionViewCell.h
//  ezhayan
//
//  Created by ChenFengbo on 16/2/23.
//  Copyright © 2016年 ChenFengbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface todoClassCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) void (^didSelectClass) (void);

@end
