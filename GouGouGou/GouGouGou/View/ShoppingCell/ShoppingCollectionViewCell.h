//
//  ShoppingCollectionViewCell.h
//  GouGouGou
//
//  Created by lanouhn on 15/7/8.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TitleList;
@interface ShoppingCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) UIImageView *pictureView;//子类目图片
@property (nonatomic, retain) UILabel *nameLabel;//子类目名称

@property (nonatomic, retain) TitleList *titleList;

@end
