//
//  SecondShopViewController.m
//  GouGouGou
//
//  Created by laouhn on 15/7/13.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "SecondShopViewController.h"
#import "SVProgressHUD.h"

@interface SecondShopViewController ()<UIWebViewDelegate>

@end

@implementation SecondShopViewController

- (void)dealloc
{
    self.urlString = nil;
    self.webView = nil;
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
        CGSize size = [UIScreen mainScreen].bounds.size;
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        [self.view addSubview:self.webView];    
        self.webView.delegate = self;
    
        NSURLRequest *requst = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://cloud.yijia.com/goto/item.php"]];
    
    //http://cloud.yijia.com/goto/item.php
    // 禁止下拉网页
    for(id subview in _webView.subviews){
        if([[subview  class] isSubclassOfClass:[UIScrollView class]])
            ((UIScrollView *)subview).bounces = NO;
        _webView.scrollView.bounces = NO;
    }
    
        [self.webView loadRequest:requst];
        [self.webView release];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD showWithStatus:@"正在加载" maskType:SVProgressHUDMaskTypeNone];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:@"加载失败" duration:2];
}


- (void)viewWillDisappear:(BOOL)animated{
    [SVProgressHUD dismiss];
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
