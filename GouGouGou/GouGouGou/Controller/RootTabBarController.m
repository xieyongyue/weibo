//
//  RootViewController.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/2.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "RootTabBarController.h"
#import "HomeViewController.h"
#import "LeftSlideTableViewController.h"
#import "FindTableViewController.h"
#import "ShoppingViewController.h"
#import "ThemeTableViewController.h"
#import "MyTableViewController.h"
#import "ICSDrawerController.h"
#import "SVProgressHUD.h"
@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    self.homeVC = [[HomeViewController alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UINavigationController *homeNAVC = [[[UINavigationController alloc] initWithRootViewController:self.homeVC] autorelease];
    
    self.homeVC.navigationItem.title = @"购物";

    
    homeNAVC.tabBarItem.image = [UIImage imageNamed:@"53-house"];
    homeNAVC.tabBarItem.title = @"主页";
    
    ShoppingViewController *shopVC = [[ShoppingViewController alloc] init];
    UINavigationController *shopNAVC = [[[UINavigationController alloc] initWithRootViewController:shopVC] autorelease];
    shopNAVC.tabBarItem.image = [UIImage imageNamed:@"80-shopping-cart"];
    shopNAVC.tabBarItem.title = @"逛逛";
    
    FindTableViewController *findVC = [[FindTableViewController alloc] init];
    UINavigationController *findNAVC = [[[UINavigationController alloc] initWithRootViewController:findVC] autorelease];
    findNAVC.tabBarItem.image = [UIImage imageNamed:@"12-eye"];
    findNAVC.tabBarItem.title = @"发现";
    
    ThemeTableViewController *themeVC = [[ThemeTableViewController alloc] init];
    UINavigationController *themeNAVC = [[[UINavigationController alloc] initWithRootViewController:themeVC] autorelease];
    themeNAVC.tabBarItem.image = [UIImage imageNamed:@"69-display"];
    themeNAVC.tabBarItem.title = @"主题";
    
    MyTableViewController *myVC = [[MyTableViewController alloc] init];
    UINavigationController *myNAVC = [[[UINavigationController alloc] initWithRootViewController:myVC] autorelease];
    myNAVC.tabBarItem.image = [UIImage imageNamed:@"29-heart"];
    myNAVC.tabBarItem.title = @"我的空间";
    
    
    self.viewControllers = @[homeNAVC, shopNAVC, findNAVC, themeNAVC, myNAVC];
    
    self.homeVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pressslidebutton)];

    [self.homeVC release];
    [findVC release];
    [shopVC release];
    [themeVC release];
    [myVC release];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [SVProgressHUD dismiss];
}

- (void)viewWillAppear:(BOOL)animated {
    [SVProgressHUD dismiss];
}

#pragma mark - Configuring the view’s layout behavior

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - ICSDrawerControllerPresenting

- (void)drawerControllerWillOpen:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = NO;

}

- (void)drawerControllerDidClose:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = YES;

}


- (void)pressslidebutton
{
  
    
    [self.drawer open];
   
    
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
