//
//  ChoiceCell.h
//  travelFree
//
//  Created by zhufengzhu on 15/12/21.
//  Copyright © 2015年 zhufengzhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChoiceDetailCellModel.h"
@interface ChoiceCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (nonatomic,strong) ChoiceDetailCellModel *model;
@end
