//
//  slideCell.h
//  travelFree
//
//  Created by zhufengzhu on 16/1/4.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideModel.h"
@interface SlideCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;


@property (strong,nonatomic)SlideModel *model;

@end
