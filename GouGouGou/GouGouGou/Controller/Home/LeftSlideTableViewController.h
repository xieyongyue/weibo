//
//  LeftSlideTableViewController.h
//  GouGouGou
//
//  Created by lanouhn on 15/7/2.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICSDrawerController.h"
@interface LeftSlideTableViewController : UITableViewController<ICSDrawerControllerChild, ICSDrawerControllerPresenting>
@property(nonatomic, retain) ICSDrawerController *drawer;


@end
