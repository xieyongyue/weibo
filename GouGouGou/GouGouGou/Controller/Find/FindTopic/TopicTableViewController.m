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
#import "DetailViewController.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"

@interface TopicTableViewController ()<NSXMLParserDelegate>

//用于存放TitleList对象
@property (nonatomic, retain) NSMutableArray *listArray, *detailUrlArray;

@end

@implementation TopicTableViewController

#pragma mark - LifeCycle

- (void)dealloc
{
    self.detailUrlArray = nil;
    self.listArray = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"主题街";
    //解决tableView被navigationbar挡住问题
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.tableFooterView = [[[UITableView alloc] init] autorelease];
    [self netWork];
}

- (void)netWork {
    [SVProgressHUD show];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *urlString = [NSString stringWithFormat:@"http://app.shicimingju.com/chaxun/api_shiren?"];
    //http://app.api.yijia.com/tb99/iphone/zhuanti.php
    //http://app.shicimingju.com/chaxun/api_shiren?callback=jsonpReturn&callback=jQuery2130015927655156701803_1439010443130&from=ios&niandai_id=1&page=1&_=1439010443131
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //responseObject, 解析过后的数据
        NSArray *tempArray = responseObject;
//        NSLog(@"====%@", responseObject);
        //创建临时的数据mArray存储当前页的数据
        NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:0];
        //创建临时的数组nArray存储当前页的图片详细地址数据
        NSMutableArray *nArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in tempArray) {
            TitleList *titleList = [[TitleList alloc] init];
            titleList.title = dic[@"title"];
            titleList.pictureName = dic[@"pic_b_url"];
            titleList.topicTime = dic[@"addtime"];
            [nArray addObject:dic[@"detail_url"]];
            [mArray addObject:titleList];
            [titleList release];
        }
        self.listArray = [NSMutableArray arrayWithArray:mArray];
        self.detailUrlArray = [NSMutableArray arrayWithArray:nArray];
        [SVProgressHUD dismiss];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error:%@", error);
        [SVProgressHUD dismissWithError:@"加载失败"];
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [SVProgressHUD dismiss];
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
    cell.timeLabel.textColor = [UIColor colorWithRed:0.400 green:0.800 blue:1.000 alpha:1.000];
    cell.label.textColor = [UIColor colorWithRed:0.800 green:0.400 blue:1.000 alpha:1.000];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = [UIScreen mainScreen].bounds.size;
    return size.height / 3.28;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.detailUrl = self.detailUrlArray[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}

@end

