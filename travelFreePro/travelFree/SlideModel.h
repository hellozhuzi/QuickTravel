//
//  SlideModel.h
//  travelFree
//
//  Created by zhufengzhu on 16/1/4.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "JSONModel.h"

@interface SlideModel : JSONModel
@property (nonatomic,copy)NSString<Optional> *imgUrl;
@property (nonatomic,copy)NSString<Optional> *title;
@property (nonatomic,copy)NSString<Optional> *price;
@property (nonatomic,copy)NSString<Optional> *departureTime;
@property (nonatomic,copy)NSString<Optional> *url;
@property (nonatomic,copy)NSString<Optional> *productTypeEngDesc;
@property (nonatomic,copy)NSString<Optional> *type;
@end
