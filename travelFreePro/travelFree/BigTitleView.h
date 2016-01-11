//
//  BigTitleView.h
//  travelFree
//
//  Created by zhufengzhu on 15/12/25.
//  Copyright © 2015年 zhufengzhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BigTitleView : UIView

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *desLabel;
- (instancetype)initWithOrigin:(CGPoint) origin andTitle:(NSString *)title andDes:(NSString *)des;
@end
