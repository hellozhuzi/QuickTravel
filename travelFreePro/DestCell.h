//
//  DestCell.h
//  travelFree
//
//  Created by zhufengzhu on 16/1/7.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DestModel.h"
@interface DestCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameEnLabel;

@property (nonatomic,strong) DestModel *model;

@end
