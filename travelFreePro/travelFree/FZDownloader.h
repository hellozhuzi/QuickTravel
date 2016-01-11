//
//  FZDownloader.h
//  travelFree
//
//  Created by zhufengzhu on 15/12/20.
//  Copyright © 2015年 zhufengzhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FZDownloader : NSObject
- (void)downloadWithUrl:(NSString *)urlStr finishBlock:(void (^)(NSData *data))finishBlock failBlock:(void (^)(NSError *error))failBlock;
@end
