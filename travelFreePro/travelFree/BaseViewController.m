//
//  BaseViewController.m
//  travelFree
//
//  Created by zhufengzhu on 15/12/20.
//  Copyright © 2015年 zhufengzhu. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
{
    UIImageView *_navBarView;
    UILabel *_titleLabel;
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
//    self.navigationController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgTop"]];
    // Do any additional setup after loading the view.
    [self creatNavBarView];
    [self addlabelTitle];
}
- (void)creatNavBarView
{
    //?这边加20的高度，刚好和下面的按钮在一起
    _navBarView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, NAVFRAME.size.height+20)];
    NSLog(@"加10");
    _navBarView.userInteractionEnabled = YES;
    _navBarView.image = [UIImage imageNamed:@"bgTop"];
    [self.view addSubview:_navBarView];
}
- (void)addLeftNavBtnWithImage:(NSString *)imageName
{
    CGFloat width = ScreenWidth/10;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(5, NAVFRAME.size.height+20-width*4/4, width, width)];
    UIImage *image = [UIImage imageNamed:imageName];
    
    [button setImage:image forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [_navBarView addSubview:button];
    
}
- (void)leftBtnClicked:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addlabelTitle
{
    CGFloat width = ScreenWidth/4;
    CGFloat height = NAVFRAME.size.height*3/4;
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-width)/2, NAVFRAME.size.height+20-height, width, height)];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:20];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"";
    [_navBarView addSubview:_titleLabel];
}
- (void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
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
