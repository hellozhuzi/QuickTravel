//
//  FZDownloader.m
//  travelFree
//
//  Created by zhufengzhu on 15/12/20.
//  Copyright © 2015年 zhufengzhu. All rights reserved.
//

#import "FZDownloader.h"
#import "AFNetworking.h"
typedef void(^AFBlock)(NSData *requestData);
typedef void(^failBlock)(NSError *error);
@interface FZDownloader ()
@property (nonatomic,strong) AFBlock finishBlock;
@property (nonatomic,strong) failBlock failBlock;
@end

@implementation FZDownloader
- (void)downloadWithUrl:(NSString *)urlStr finishBlock:(void (^)(NSData *data))finishBlock failBlock:(void (^)(NSError *error))failBlock
{
    _finishBlock = finishBlock;
    _failBlock = failBlock;
    [self httpRequestWith:urlStr];
}
-(void)httpRequestWith:(NSString *)urlString{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
        
        _finishBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _failBlock(error);
    }];
    
}

//ssesion处理
//- (void)downloadWithUrl:(NSString *)urlStr finishBlock:(void (^)(NSData *data))finishBlock failBlock:(void (^)(NSError *error))failBlock
//{
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
//    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if(error){
//            failBlock(error);
//            NSLog(@"download failed,url :%@",urlStr);
//        }
//        else{
//            NSLog(@"dl=%@请求%@成功\n",self,urlStr);
//            finishBlock(data);
//        }
//        
//    }];
//    [task resume];
//}
@end
