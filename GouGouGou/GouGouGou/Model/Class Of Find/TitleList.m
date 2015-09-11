//
//  TitleList.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/2.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "TitleList.h"

@implementation TitleList

- (void)dealloc
{
    self.CID = nil;
    self.logo = nil;
    self.topicTime = nil;
    self.title = nil;
    self.discount = nil;
    self.goodName = nil;
    self.pictureName = nil;
    self.brandName = nil;
    self.now_price = nil;
    self.origin_price = nil;
    [super dealloc];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"title:%@\n pictureName:%@", self.title, self.pictureName];
}

- (id)initWithTitle:(NSString *)title pictureName:(NSString *)pictureName {
    self = [super init];
    if (self) {
        self.title = title;
        self.pictureName = pictureName;
    }
    return self;
}

+ (id)titleListWithTitle:(NSString *)title pictureName:(NSString *)pictureName {
    return [[[TitleList alloc] initWithTitle:title pictureName:pictureName] autorelease];
}

#pragma mark - NSCoding

//编码方法
- (void)encodeWithCoder:(NSCoder *)aCoder {
    self.logo = nil;
    self.topicTime = nil;
    self.title = nil;
    self.discount = nil;
    self.goodName = nil;
    self.pictureName = nil;
    self.brandName = nil;
    self.now_price = nil;
    self.origin_price = nil;
    [aCoder encodeObject:self.CID forKey:@"CID"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.pictureName forKey:@"pictureName"];
    [aCoder encodeObject:self.discount forKey:@"discount"];
    [aCoder encodeObject:self.now_price forKey:@"now_price"];
    [aCoder encodeObject:self.origin_price forKey:@"origin_price"];
    [aCoder encodeObject:self.logo forKey:@"logo"];
}
//解码方法
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.CID = [aDecoder decodeObjectForKey:@"CID"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.pictureName = [aDecoder decodeObjectForKey:@"pictureName"];
        self.discount = [aDecoder decodeObjectForKey:@"discount"];
        self.now_price = [aDecoder decodeObjectForKey:@"now_price"];
        self.origin_price = [aDecoder decodeObjectForKey:@"origin_price"];
        self.logo = [aDecoder decodeObjectForKey:@"logo"];
    }
    return self;
}

@end
