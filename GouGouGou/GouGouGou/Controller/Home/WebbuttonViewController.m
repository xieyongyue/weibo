//
//  WebbuttonViewController.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/9.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "WebbuttonViewController.h"
#import "SVProgressHUD.h"
@interface WebbuttonViewController ()<UIWebViewDelegate>



@end

@implementation WebbuttonViewController

- (void)dealloc
{
    self.titlestring = nil;
    self.urlstring = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD dismiss];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = self.titlestring;
    CGSize size = [UIScreen mainScreen].bounds.size;
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    webview.delegate = self;
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlstring]]];
    [self.view addSubview:webview];
    
    [webview release];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -UIWebViewDelegate
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//    return YES;
//}

- (void)webViewDidFinishLoad:(UIWebView *)webView{

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

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
