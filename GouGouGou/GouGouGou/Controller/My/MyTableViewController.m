//
//  MyTableViewController.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/2.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "MyTableViewController.h"
#import "AboutUsViewController.h"
#import "FeedBackViewController.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "MyCell.h"

#define kMargin ([UIScreen mainScreen].bounds.size.width) / 375
@interface MyTableViewController ()<UIAlertViewDelegate>

@property (nonatomic, retain) NSArray *listArray;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *cleanLabel;

@end

@implementation MyTableViewController

#pragma mark - LifeCycle

- (void)dealloc
{
    self.listArray = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的空间";
    
    self.listArray = @[@"清理缓存", @"意见反馈", @"关于我们"];
    self.rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"me_day"] style:UIBarButtonItemStyleDone target:self action:@selector(change)];
    self.navigationItem.rightBarButtonItem = self.rightItem;
    
    self.tableView.tableFooterView = [[[UITableView alloc] init] autorelease];
    self.tableView.alwaysBounceHorizontal = YES;
    self.cleanLabel = [[UILabel alloc] initWithFrame:CGRectMake(250 * kMargin, 15 * kMargin, 110 * kMargin, 20 * kMargin)];

}

- (void)change {
    if (self.flag) {
        self.rightItem.image = [UIImage imageNamed:@"me_day"];
        self.view.window.alpha = 1.0;
        self.flag = NO;
    } else {
        self.rightItem.image = [UIImage imageNamed:@"me_moon"];
        self.view.window.alpha = 0.4;
        self.flag = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [SVProgressHUD dismiss];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    return [self.listArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"cell";
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[MyCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier] autorelease];
    }
    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        self.cleanLabel.text = [self libarySizeChange:[self filePath]];
        [cell addSubview:self.cleanLabel];
    } else {

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.listArray[indexPath.row];
    return cell;
}

- (void)clearAA{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"确定清理缓存吗" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alertView show];
    [alertView release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[SDImageCache sharedImageCache] clearDisk];
        [[SDImageCache sharedImageCache] clearMemory];
        self.cleanLabel.text = [NSString stringWithFormat:@"%.2fMB", [[SDImageCache sharedImageCache] getSize] / 1024.0 / 1024.0];
    }
}

//----------------
// ************************* 缓存大小******************
//2: 遍历文件夹获得文件夹大小，返回多少 M（提示：你可以在工程界设置（)m）

// 根据路径找到某个文件夹下的文件大小
- ( float ) folderSizeAtPath:( NSString *) folderPath{
    
    // 创建管理
    NSFileManager * manager = [ NSFileManager defaultManager ];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ]; // //从前向后枚举器
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    return folderSize/( 1024.0 * 1024.0 );
}

// ///计算缓存文件的大小的 M
- ( long long ) fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [ NSFileManager defaultManager ];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
    }
    return 0 ;
}

// 显示缓存大小
- ( float )filePath
{
    // 找到缓存的文件夹的路径
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    // 调用方法计算缓存的大小
     float f = [self folderSizeAtPath :cachPath];
    return f;
}
- (NSString *)libarySizeChange:(float)size {
    if (size < 1) {
        return [NSString stringWithFormat:@"%dk", (int)size * 1024];
    } else {
        return [NSString stringWithFormat:@"%.2fM", size];
    }
}

//----------------
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGSize size = [UIScreen mainScreen].bounds.size;
    if (section == 0) {
        return size.height / 22.23;
    }
    return size.height / 33.35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        if ([self.cleanLabel.text isEqualToString:@"0.00MB"]) {
            return;
        } else {
            [self clearAA];
        }
    } else if (indexPath.row == 1) {
        FeedBackViewController *feedVC = [[FeedBackViewController alloc] init];
        [self.navigationController pushViewController:feedVC animated:YES];
        [feedVC release];
    }else {
        AboutUsViewController *ABVC = [[AboutUsViewController alloc] init];
        [self.navigationController pushViewController:ABVC animated:YES];
        [ABVC release];
    }
}

#pragma mark - Action




@end
