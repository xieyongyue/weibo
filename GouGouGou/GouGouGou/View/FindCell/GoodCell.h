//
//  GoodCell.h
//  GouGouGou
//
//  Created by lanouhn on 15/7/7.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TitleList;
@interface GoodCell : UITableViewCell

@property (nonatomic, retain) UIImageView *pictureView, *logoView;
@property (nonatomic, retain) UILabel *label, *timeLabel, *nameLabel, *countLabel;
@property (nonatomic, retain) TitleList *titleList;


@end
