//
//  Bottomview.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/10.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "Bottomview.h"

@implementation Bottomview

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)dealloc
{

    self.bottomimageview = nil;
    self.collectlabel = nil;
    self.Recommondneimagewview = nil;
    self.titillabel = nil;
    self.pricelabel = nil;
    [super dealloc];
}



- (id)initWithFrame:(CGRect)frame{
    
    
    self = [super initWithFrame:frame];
    if (self) {
        CGSize size = [[UIScreen mainScreen] bounds].size;
        self.Recommondneimagewview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        self.Recommondneimagewview.frame = CGRectMake(0, 0, size.width/2. - 30, size.height/4);
        [self addSubview:self.Recommondneimagewview];
        [self.Recommondneimagewview release];
        
        self.pricelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, size.height/4 - size.height/20, size.width/2. - 30, size.height/20)];
        self.pricelabel.textColor = [UIColor colorWithRed:1.000 green:0.000 blue:0.502 alpha:1.000];
        self.pricelabel.font = [UIFont systemFontOfSize:15];
        self.pricelabel.backgroundColor = [UIColor colorWithWhite:0.800 alpha:0.500];
        
        [self.Recommondneimagewview addSubview:self.pricelabel];
        [self.pricelabel release];
        
        self.titillabel = [[UILabel alloc] initWithFrame:CGRectMake(0, size.height/4, size.width/2. - 30, 40)];
        [self addSubview:self.titillabel];
        [self.titillabel setNumberOfLines:0];
        self.titillabel.adjustsFontSizeToFitWidth = YES;
        [self.titillabel release];
       
    }
    
    
    return self;
}




@end
