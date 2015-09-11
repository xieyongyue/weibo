//
//  DetailViewController.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/7.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "DetailViewController.h"
#import "SVProgressHUD.h"

@interface DetailViewController ()<UIWebViewDelegate>

@property (nonatomic, retain) UIWebView *webView;

@end

@implementation DetailViewController

#pragma mark - LifeCycle

- (void)dealloc
{
    self.webView= nil;
    self.detailUrl = nil;
    self.titleString = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.titleString;
    CGRect rect = [UIScreen mainScreen].bounds;
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.detailUrl]];
    [self.webView loadRequest:request];
    [self.webView release];
}

#pragma mark -UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    [SVProgressHUD show];
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if ([error code] == NSURLErrorCancelled) {
        return;
    }
    [SVProgressHUD dismissWithError:@"加载失败"];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.webView.delegate = nil;
    [SVProgressHUD dismiss];
}

- (void)viewWillAppear:(BOOL)animated {
    [SVProgressHUD dismiss];
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
