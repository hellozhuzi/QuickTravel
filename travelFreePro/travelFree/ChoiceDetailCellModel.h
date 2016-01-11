//
//  ChoiceDetailCellModel.h
//  travelFree
//
//  Created by zhufengzhu on 15/12/21.
//  Copyright © 2015年 zhufengzhu. All rights reserved.
//

#import "JSONModel.h"

@interface ChoiceDetailCellModel : JSONModel
@property(nonatomic,copy)NSString<Optional> *pic;
@property(nonatomic,copy)NSString<Optional> *title;
@property(nonatomic,copy)NSString<Optional> *departureTime;
@property(nonatomic,copy)NSString<Optional> *buy_price;
@property(nonatomic,copy)NSString<Optional> *lastminute_des;
@property(nonatomic,copy)NSString<Optional> *url;
@property(nonatomic,copy)NSString<Optional> *productType;
@end
