//
//  RootViewController.h
//  GouGouGou
//
//  Created by lanouhn on 15/7/2.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICSDrawerController.h"
@class ICSDrawerController;
@class HomeViewController;
@interface RootTabBarController : UITabBarController<ICSDrawerControllerChild, ICSDrawerControllerPresenting>

@property(nonatomic, retain)UIViewController *homeVC;
@property(nonatomic, retain) ICSDrawerController *drawer;

@end
