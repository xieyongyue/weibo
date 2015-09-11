//
//  AboutUsViewController.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/13.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于我们";
    self.view.backgroundColor = [UIColor colorWithRed:0.847 green:0.830 blue:1.000 alpha:1.000];
    CGRect rect = [UIScreen mainScreen].bounds;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, rect.size.height / 7.4, rect.size.width, rect.size.height / 24.7)];
    titleLabel.text = @"关于我们";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    [titleLabel release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12.3, rect.size.height / 5.13, rect.size.width - 24.6, rect.size.height / 2.0)];
    label.text = @"       GoGo购是一款基于电子交易平台的购物App,   GoGo购是以用户的体验为根本, 为您的生活提供方便快捷的购物方式。 其包含海量的商品种类,    使您可以随时随地轻松遨游在商品的海洋里,    商品详情随时更新,  使您可以掌握一手商品信息,  是不是有点迫不及待了, 快来尝试一下吧!";
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:15];
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:label.text];
    label.textAlignment = NSTextAlignmentCenter;
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:8];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [label.text length])];
    [label setAttributedText:attributedString1];
    [label sizeToFit];
    [self.view addSubview:label];
    [label release];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
