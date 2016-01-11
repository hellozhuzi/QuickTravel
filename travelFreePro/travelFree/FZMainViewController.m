//
//  FZMainViewController.m
//  travelFree
//
//  Created by zhufengzhu on 15/12/20.
//  Copyright © 2015年 zhufengzhu. All rights reserved.
//

#import "FZMainViewController.h"

@interface FZMainViewController ()

@end

@implementation FZMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatViewControllers];
    [self creatTabBar];
    
}

- (void)creatViewControllers
{

    
    //4个界面
    NSArray *controllerArray = @[@"HomeViewController",@"ClassifyViewController",@"ChoiceViewController",@"MyinfoViewController"];
    NSMutableArray *vcArray = [NSMutableArray array];
    for (int i=0; i<controllerArray.count-1; i++) {
        Class Con = NSClassFromString(controllerArray[i]);
        UIViewController *vc = [[Con alloc]init];
        UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:vc];
        [vcArray addObject:nc];
        
    }
    
    UIViewController *myinfoVc =  [[UIStoryboard storyboardWithName:@"MyinfoView" bundle:nil]instantiateViewControllerWithIdentifier:@"myinfo"];
    [vcArray addObject:myinfoVc];
    self.viewControllers = vcArray;
}
- (void)creatTabBar
{
    NSArray *title = @[@"首页",@"目的地",@"穷游精选",@"我的"];
    NSArray *btnImage = @[@"home",@"classify",@"choice",@"myinfo"];
    NSArray *btnSelImage = @[@"home_on",@"classify_on",@"choice_on",@"myinfo_on"];
    
    for (int i=0; i<btnImage.count; i++) {
        UITabBarItem *item = self.tabBar.items[i];
        UIImage *image = [UIImage imageNamed:btnImage[i]];
        UIImage *selImage = [UIImage imageNamed:btnSelImage[i]];
        item = [item initWithTitle:title[i] image:image selectedImage:selImage];
        
    }
    
    
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
