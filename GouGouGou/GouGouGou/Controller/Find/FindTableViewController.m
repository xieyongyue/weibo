//
//  FindTableViewController.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/2.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "FindTableViewController.h"
#import "FindCell.h"
#import "TitleList.h"
#import "TopicTableViewController.h"
#import "GoodTableViewController.h"
#import "SVProgressHUD.h"
#import "DetailViewController.h"

@interface FindTableViewController ()

@property (nonatomic, retain) NSArray *arrayList, *sectionArray1, *sectionArray2, *sectionArray3;

@end

@implementation FindTableViewController

#pragma mark - LifeCycle

- (void)dealloc
{
    self.sectionArray1 = nil;
    self.sectionArray2 = nil;
    self.sectionArray3 = nil;
    self.arrayList = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发现";
    self.view.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1.000];
    TitleList *titleList1 = [TitleList titleListWithTitle:@"主题街" pictureName:@"zt"];
    TitleList *titleList2 = [TitleList titleListWithTitle:@"生活街" pictureName:@"txp"];
    TitleList *titleList3 = [TitleList titleListWithTitle:@"超级买手" pictureName:@"ms"];
    TitleList *titleList4 = [TitleList titleListWithTitle:@"今天很划算" pictureName:@"zhe"];
    TitleList *titleList6 = [TitleList titleListWithTitle:@"好店" pictureName:@"zk"];
    TitleList *titleList7 = [TitleList titleListWithTitle:@"瞄一眼" pictureName:@"tm"];
    
    self.sectionArray1 = @[titleList1, titleList2];
    self.sectionArray2 = @[titleList3, titleList4];
    self.sectionArray3 = @[titleList6, titleList7];
    //把titleList类放进一个数组
    self.arrayList = @[self.sectionArray1, self.sectionArray2, self.sectionArray3];
    self.clearsSelectionOnViewWillAppear = YES;
    self.tableView.alwaysBounceHorizontal = YES;
    self.tableView.tableFooterView = [[[UITableView alloc] init] autorelease];
}

- (void)viewWillAppear:(BOOL)animated {
        [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = [UIScreen mainScreen].bounds.size;
    return size.height / 10.715;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrayList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrayList[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static  NSString *identifier = @"cell";
    FindCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[FindCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.titleList = self.arrayList[indexPath.section][indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    CGSize size = [UIScreen mainScreen].bounds.size;
    return size.height / 22.72;
}

//点击某行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        TopicTableViewController *topicVC = [[TopicTableViewController alloc] init];
        [self.navigationController pushViewController:topicVC animated:YES];
        [topicVC release];
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        DetailViewController *detailVC = [[DetailViewController alloc] init];
        detailVC.detailUrl = @"http://zhekou.yijia.com/lws/view/yijia_shop.php?app_id=1066136336&sche=fenjiujiu";
        detailVC.titleString = @"生活街";
        [self.navigationController pushViewController:detailVC animated:YES];
        [detailVC release];
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        DetailViewController *detailVC = [[DetailViewController alloc] init];
        detailVC.detailUrl = @"http://app.api.yijia.com/tb99/iphone/API/app_qipa.php";
        detailVC.titleString = @"超级买手";
        [self.navigationController pushViewController:detailVC animated:YES];
        [detailVC release];
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        DetailViewController *detailVC = [[DetailViewController alloc] init];
        detailVC.detailUrl = @"http://jkjby.yijia.com/jkjby/view/nine_web/index.php?app_id=1066136336&sche=fenjiujiu";
        detailVC.titleString =  @"今天很划算";
        [self.navigationController pushViewController:detailVC animated:YES];
        [detailVC release];
    }  else if (indexPath.section == 2 && indexPath.row == 0) {
        GoodTableViewController *goodVC = [[GoodTableViewController alloc] init];
        [self.navigationController pushViewController:goodVC animated:YES];
        [goodVC release];
    } else {
        DetailViewController *detailVC = [[DetailViewController alloc] init];
        detailVC.detailUrl = @"http://zhekou.repai.com/lws/view/zhe_miaoyiyan.php";
        detailVC.titleString = @"瞄一眼";
        [self.navigationController pushViewController:detailVC animated:YES];
        [detailVC release];
    }
}






@end
