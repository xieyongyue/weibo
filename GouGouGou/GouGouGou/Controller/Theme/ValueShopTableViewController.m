//
//  ValueShopTableViewController.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/7.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "ValueShopTableViewController.h"
#import "SVProgressHUD.h"

@interface ValueShopTableViewController ()<UIWebViewDelegate>

@property (nonatomic, retain) UIWebView *webView;

@end

@implementation ValueShopTableViewController

#pragma mark - LifeCycle

- (void)dealloc
{
    self.webView = nil;
    self.strUrl = nil;
    self.titleString = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.titleString;
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height - 108)];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    NSURLRequest *requst = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.strUrl]];
    
    [self.webView loadRequest:requst];
    [self.tableView reloadData];

    [self.webView release];
    self.tableView.tableFooterView = [[[UITableView alloc] init] autorelease];

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
    if ([self.strUrl isEqualToString:@"http://app.api.yijia.com/tb99/iphone/gotu.php?gotu=trip"]) {
        return;
    } else {
            if ([error code] == NSURLErrorCancelled) {
                return;
            }
        [SVProgressHUD dismissWithError:@"加载失败"];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    self.webView.delegate = nil;
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
// Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
