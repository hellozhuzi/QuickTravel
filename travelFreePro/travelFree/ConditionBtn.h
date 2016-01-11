//
//  ConditionBtn.h
//  travelFree
//
//  Created by zhufengzhu on 15/12/20.
//  Copyright © 2015年 zhufengzhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConditionBtn : UIButton

@property (nonatomic,strong) UILabel *btnLabel;
@property (nonatomic,strong) UIImageView *btnImageView;

- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)title anImageName:(NSString *)ImageName;
-(void)setBtnTitle:(NSString *)title;
@end
