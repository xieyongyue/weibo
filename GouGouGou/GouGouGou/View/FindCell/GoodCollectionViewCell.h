//
//  GoodCollectionViewCell.h
//  GouGouGou
//
//  Created by lanouhn on 15/7/10.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TitleList;
@interface GoodCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) UIImageView *pictureView;
@property (nonatomic, retain) UILabel *titleLabel, *originLabel, *nowLabel, *countLabel;
@property (nonatomic, retain) TitleList *titleList;

@end
