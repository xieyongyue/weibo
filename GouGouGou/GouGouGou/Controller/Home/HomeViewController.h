//
//  HomeViewController.h
//  GouGouGou
//
//  Created by lanouhn on 15/7/3.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICSDrawerController.h"
@interface HomeViewController : UIViewController
@property(nonatomic, assign) NSInteger goodsnumber, indexnumber;
@property(nonatomic, retain) ICSDrawerController *drawer;
@property(nonatomic, retain)UICollectionView *collectionView;
//@property(nonatomic, retain) NSString *idstring;


@end
