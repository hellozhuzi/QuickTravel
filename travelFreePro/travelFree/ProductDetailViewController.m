//
//  ProductDetailViewController.m
//  travelFree
//
//  Created by zhufengzhu on 16/1/4.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "ProductDetailViewController.h"

@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController
//网页文件
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self creatWebView];
}

- (void)setNav
{
    [self  addLeftNavBtnWithImage:@"btn_back@2x"];

}
- (void)creatWebView
{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,NAVFRAME.size.height+20, ScreenWidth, ScreenHeight)];
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
