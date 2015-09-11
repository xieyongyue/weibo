//
//  HeaderViewController.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/9.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "HeaderViewController.h"

@interface HeaderViewController ()

@end

@implementation HeaderViewController

- (void)dealloc
{
    self.webView1 = nil;
    self.string = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect rect = [UIScreen mainScreen].bounds;
    self.webView1 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    [self.view addSubview:self.webView1];
   
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.string]];
    [self.webView1 loadRequest:request];
    [self.webView1 release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
