//
//  ChoiceModel.h
//  travelFree
//
//  Created by zhufengzhu on 16/1/6.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "JSONModel.h"

@interface ChoiceModel : JSONModel
@property(nonatomic,copy)NSString<Optional> *ids;
@property(nonatomic,copy)NSString<Optional> *img;
@property(nonatomic,copy)NSString<Optional> *title;
@end
