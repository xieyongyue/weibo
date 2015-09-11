//
//  TopicTableViewController.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/3.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "GoodTableViewController.h"
#import "GoodCell.h"
#import "AFNetworking.h"
#import "TitleList.h"
#import "SVPullToRefresh.h"
#import "GoodViewController.h"
#import "SVProgressHUD.h"


@interface GoodTableViewController ()<NSXMLParserDelegate>

//用于存放TitleList对象
@property (nonatomic, retain) NSMutableArray *listArray, *detailUrlArray;

@end

@implementation GoodTableViewController

#pragma mark - LifeCycle

- (void)dealloc
{
    self.detailUrlArray = nil;
    self.listArray = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"好店";
    //解决tableView被navigationbar挡住问题
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self netWork];
    [SVProgressHUD show];
    self.tableView.tableFooterView = [[[UITableView alloc] init] autorelease];
}

- (void)netWork {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        NSString *urlString = [NSString stringWithFormat:@"http://app.api.yijia.com/newapps/gsc/api/mshop.php?model=index"];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //responseObject, 解析过后的数据
        NSArray *tempArray = responseObject;
        //创建临时的数据mArray存储当前页的数据
        NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:0];
        //创建临时的数组nArray存储当前页的图片详细地址数据
        NSMutableArray *nArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in tempArray) {
            TitleList *titleList = [[TitleList alloc] init];
            titleList.title = dic[@"title"];
            titleList.discount = dic[@"discount"];
            titleList.goodName = dic[@"info"];
            titleList.pictureName = dic[@"pic"];
            titleList.topicTime = dic[@"date"];
            titleList.logo = dic[@"logo"];
            
            [nArray addObject:dic[@"id"]];
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
    GoodCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[GoodCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    cell.titleList = self.listArray[indexPath.row];
    cell.timeLabel.textColor = [UIColor colorWithRed:0.400 green:0.800 blue:1.000 alpha:1.000];
    cell.label.textColor = [UIColor colorWithRed:0.800 green:0.400 blue:1.000 alpha:1.000];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = [UIScreen mainScreen].bounds.size;
    return size.height / 3.2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodViewController *goodVC = [[GoodViewController alloc] init];
    goodVC.idString = self.detailUrlArray[indexPath.row];
    [self.navigationController pushViewController:goodVC animated:YES];
    [goodVC release];
    
}



@end


