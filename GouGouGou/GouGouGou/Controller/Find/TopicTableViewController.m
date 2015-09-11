//
//  TopicTableViewController.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/3.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "TopicTableViewController.h"
#import "TopicCell.h"
#import "AFNetworking.h"
#import "TitleList.h"
#import "SVPullToRefresh.h"

@interface TopicTableViewController ()<NSXMLParserDelegate>

//用于存放TitleList对象
@property (nonatomic, retain) NSMutableArray *listArray;
//@property (nonatomic, assign) NSInteger page;//页数
@property (nonatomic, retain) UIWebView *webView1, *webView2, *webView3, *webView4, *webView5, *webView6, *webView7;

@end

@implementation TopicTableViewController

- (void)dealloc
{
    self.webView1 = nil;
    self.webView2 = nil;
    self.webView3 = nil;
    self.webView1 = nil;
    self.webView5 = nil;
    self.webView6 = nil;
    self.webView7 = nil;
    self.listArray = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"主题街";
    
    //解决tableView被navigationbar挡住问题
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.page = 1;
    //添加下拉加载最新数据
    [self.tableView addPullToRefreshWithActionHandler:^{
//        self.page = 1;
        [self netWork];
    }];
    //添加上拉加载最新数据
    [self.tableView addInfiniteScrollingWithActionHandler:^{
//        self.page++;
        [self netWork];
    }];
    [self netWork];
}

- (void)netWork {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *urlString = [NSString stringWithFormat:@"http://app.api.yijia.com/tb99/iphone/zhuanti.php?"];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //responseObject, 解析过后的数据
        NSLog(@"JSON:%@", responseObject);
        NSArray *tempArray = responseObject;
        //创建临时的数据mArray存储当前页的数据
        NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in tempArray) {
            TitleList *titleList = [[TitleList alloc] init];
            titleList.title = dic[@"title"];
            titleList.pictureName = dic[@"pic_b_url"];
            titleList.topicTime = dic[@"addtime"];
            [mArray addObject:titleList];
            [titleList release];
        }
        self.listArray = [NSMutableArray arrayWithArray:mArray];
//        [self.tableView.pullToRefreshView stopAnimating];
//        [self.tableView.infiniteScrollingView stopAnimating];
//        if (self.page == 1) {
//            self.listArray = [NSMutableArray arrayWithArray:mArray];
//            [self.tableView.pullToRefreshView stopAnimating];
//        } else {
//            [self.listArray addObjectsFromArray:mArray];
//            [self.tableView.infiniteScrollingView stopAnimating];
//        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error:%@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   static NSString *identifier = @"cell";
    TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[TopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    cell.titleList = self.listArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TopicCell heightOfCell:self.listArray[indexPath.row]];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CGRect rect = [UIScreen mainScreen].bounds;
        self.webView1 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        [self.view addSubview:self.webView1];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=get_sec_ten_two_view&id=19956&title=%E5%A5%B3%E7%A5%9E%E4%BF%AE%E7%82%BC%E7%A7%98%E7%B1%8D"]];
        [self.webView1 loadRequest:request];
        [self.webView1 release];
        self.tableView.tableFooterView = [[[UITableView alloc] init] autorelease];
    } else if (indexPath.row == 1) {
        CGRect rect = [UIScreen mainScreen].bounds;
        self.webView2 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        [self.view addSubview:self.webView2];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=get_sec_ten_two_view&id=19942&title=%E7%94%B7%E5%8F%8B%E4%B9%9F%E6%98%AF%E6%9D%A1%E7%BA%B9%E6%8E%A7"]];
        [self.webView2 loadRequest:request];
        [self.webView2 release];
        self.tableView.tableFooterView = [[[UITableView alloc] init] autorelease];
    } else if (indexPath.row == 2) {
        CGRect rect = [UIScreen mainScreen].bounds;
        self.webView3 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        [self.view addSubview:self.webView3];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=get_sec_ten_two_view&id=19950&title=%E5%9C%A8%E5%AE%B6%E5%B0%B1%E7%A9%BF%E6%B8%85%E5%87%89%E7%82%B9"]];
        [self.webView3 loadRequest:request];
        [self.webView3 release];
        self.tableView.tableFooterView = [[[UITableView alloc] init] autorelease];
    } else if (indexPath.row == 3) {
        CGRect rect = [UIScreen mainScreen].bounds;
        self.webView4 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        [self.view addSubview:self.webView4];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=get_sec_ten_two_view&id=19686&title=%E7%BB%99%E8%BF%9E%E8%A1%A3%E8%A3%99%E6%8D%A2%E6%8D%A2%E5%8F%A3%E5%91%B3"]];
        [self.webView4 loadRequest:request];
        [self.webView4 release];
        self.tableView.tableFooterView = [[[UITableView alloc] init] autorelease];
    } else if (indexPath.row == 4) {
        CGRect rect = [UIScreen mainScreen].bounds;
        self.webView5 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        [self.view addSubview:self.webView5];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=get_sec_ten_two_view&id=19748&title=%E5%B0%8F%E7%BC%96%E6%95%99%E4%BD%A0%E9%AB%98%E5%88%86%E7%A9%BF%E8%A1%A3%E7%A7%98%E8%AF%80"]];
        [self.webView5 loadRequest:request];
        [self.webView5 release];
        self.tableView.tableFooterView = [[[UITableView alloc] init] autorelease];
    } else if (indexPath.row == 5) {
        CGRect rect = [UIScreen mainScreen].bounds;
        self.webView6 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        [self.view addSubview:self.webView6];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=get_sec_ten_two_view&id=19779&title=20%E5%B2%81%E5%BF%85%E5%A4%87%E7%9A%8420%E4%BB%B6"]];
        [self.webView6 loadRequest:request];
        [self.webView6 release];
        self.tableView.tableFooterView = [[[UITableView alloc] init] autorelease];
    } else {
        CGRect rect = [UIScreen mainScreen].bounds;
        self.webView7 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        [self.view addSubview:self.webView7];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=get_sec_ten_two_view&id=19508&title=%E8%A1%A3%E6%A9%B1%E5%B0%91%E4%B8%8D%E4%BA%86%E7%9A%84%E6%BD%AE%E6%B5%81%E6%AC%BE"]];
        [self.webView7 loadRequest:request];
        [self.webView7 release];
        self.tableView.tableFooterView = [[[UITableView alloc] init] autorelease];
    }
}

@end

//1 http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=get_sec_ten_two_view&id=19956&title=%E5%A5%B3%E7%A5%9E%E4%BF%AE%E7%82%BC%E7%A7%98%E7%B1%8D

//2 http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=get_sec_ten_two_view&id=19942&title=%E7%94%B7%E5%8F%8B%E4%B9%9F%E6%98%AF%E6%9D%A1%E7%BA%B9%E6%8E%A7

//3 http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=get_sec_ten_two_view&id=19950&title=%E5%9C%A8%E5%AE%B6%E5%B0%B1%E7%A9%BF%E6%B8%85%E5%87%89%E7%82%B9

//4 http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=get_sec_ten_two_view&id=19686&title=%E7%BB%99%E8%BF%9E%E8%A1%A3%E8%A3%99%E6%8D%A2%E6%8D%A2%E5%8F%A3%E5%91%B3

//5 http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=get_sec_ten_two_view&id=19748&title=%E5%B0%8F%E7%BC%96%E6%95%99%E4%BD%A0%E9%AB%98%E5%88%86%E7%A9%BF%E8%A1%A3%E7%A7%98%E8%AF%80

//6 http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=get_sec_ten_two_view&id=19779&title=20%E5%B2%81%E5%BF%85%E5%A4%87%E7%9A%8420%E4%BB%B6

//7 http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=get_sec_ten_two_view&id=19508&title=%E8%A1%A3%E6%A9%B1%E5%B0%91%E4%B8%8D%E4%BA%86%E7%9A%84%E6%BD%AE%E6%B5%81%E6%AC%BE"


