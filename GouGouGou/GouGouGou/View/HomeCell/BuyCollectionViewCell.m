//
//  BuyCollectionViewCell.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/7.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "BuyCollectionViewCell.h"
#import "Bottomview.h"
@implementation BuyCollectionViewCell

- (void)dealloc
{
    self.leftview = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        CGSize size = [[UIScreen mainScreen] bounds].size;
        self.leftview = [[Bottomview alloc] initWithFrame:CGRectMake(0, 0, size.width/2 - 30, size.height/4)];
        [self addSubview:self.leftview];
        [self.leftview release];

    }
    
   
    return self;
}

@end
