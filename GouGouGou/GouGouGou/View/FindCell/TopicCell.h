//
//  TopicCell.h
//  GouGouGou
//
//  Created by lanouhn on 15/7/3.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TitleList;
@interface TopicCell : UITableViewCell

@property (nonatomic, retain) UIImageView *pictureView;
@property (nonatomic, retain) UILabel *label, *timeLabel;
@property (nonatomic, retain) TitleList *titleList;


@end
