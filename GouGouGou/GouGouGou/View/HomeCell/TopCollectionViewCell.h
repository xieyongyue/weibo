//
//  TopCollectionViewCell.h
//  GouGouGou
//
//  Created by lanouhn on 15/7/10.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
@interface TopCollectionViewCell : UICollectionViewCell

@property(nonatomic,assign)UIImageView *purchaseimageview, *rechargeimageview, *lifestreetimageview, *lotteryimageview;

@property(nonatomic, retain)SDCycleScrollView *sdCycleScrollView;



@end
