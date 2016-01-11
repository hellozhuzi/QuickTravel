//
//  DestModel.h
//  travelFree
//
//  Created by zhufengzhu on 16/1/7.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "JSONModel.h"

@interface DestModel : JSONModel
@property(nonatomic,copy)  NSString <Optional>*city_id;
@property(nonatomic,copy)  NSString <Optional>*country_id;
@property(nonatomic,copy)  NSString <Optional>*name;
@property(nonatomic,copy)  NSString <Optional>*name_en;
@property(nonatomic,copy)  NSString <Optional>*open_type;
@property(nonatomic,copy)  NSString <Optional>*pic;
@property(nonatomic,copy)  NSString <Optional>*url;
@end
