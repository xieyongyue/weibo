//
//  ShoppingViewController.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/8.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//
#import "UIImageView+WebCache.h"

#import "ShoppingViewController.h"
#import "ShoppingCollectionViewCell.h"
#import "ShoppingCell.h"
#import "HeaderView.h"
#import "AFNetworking.h"
#import "SVPullToRefresh.h"
#import "HeaderViewController.h"
#import "TitleList.h"
#import "SVProgressHUD.h"
#import "SecondShopViewController.h"

static NSString *str = @"cell";
static NSString *cellIdentifier = @"Mycell";
@interface ShoppingViewController ()<UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) UITableView *leftView;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger selectedIndex, page;
@property (nonatomic, retain) NSMutableArray  *nameArray, *pictureArrayUrl, *cidPictureArray, *pictureArray, *IDArray;
@property (nonatomic, retain) NSArray *listArray;
@property (nonatomic, retain) NSString *stringUrl;

@end

@implementation ShoppingViewController

#pragma mark - LifeCycle

- (void)dealloc
{
    self.IDArray = nil;
    self.stringUrl = nil;
    self.listArray = nil;
    self.nameArray = nil;
    self.pictureArray = nil;
    self.leftView = nil;
    self.collectionView = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self netWork];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"逛商场";
    //解决tableView被navigationbar挡住问题
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //cell大小
    layout.itemSize = CGSizeMake(size.width / 5.357, size.height / 6.67);
    //分区边距(上左下右)
    layout.sectionInset = UIEdgeInsetsMake(size.height / 66.7, size.width / 18.75, size.height / 33.35, size.width / 18.75);
    //最小行间距
    layout.minimumLineSpacing = size.height / 44.467;
    layout.minimumInteritemSpacing = size.width / 37.5;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(size.width / 4.6875, size.height / 6.67, size.width / 1.26, size.height - 200) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.alwaysBounceHorizontal = YES;
    [self.view addSubview:self.collectionView];
    [layout release];
    [self.collectionView release];
    //注册cell类型
    [self.collectionView registerClass:[ShoppingCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    
    self.leftView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, size.width / 4.6875, size.height)];
    [self.view addSubview:self.leftView];
    self.leftView.delegate = self;
    self.leftView.dataSource = self;
    self.leftView.tableFooterView = [[[UITableView alloc] init] autorelease];
    self.leftView.alwaysBounceHorizontal = YES;
    [self.leftView release];
    //注册cell类型
    [self.leftView registerClass:[ShoppingCell class] forCellReuseIdentifier:str];

    self.headerView = [[HeaderView alloc] initWithFrame:CGRectMake(size.width / 4.16, size.height / 66.7, size.width / 1.37, size.height / 6.67)];
    self.headerView.backgroundColor = [UIColor whiteColor];
    self.headerView.userInteractionEnabled = YES;
    [self.view addSubview:self.headerView];
    [self.headerView release];
    UIButton *button= [UIButton buttonWithType:UIButtonTypeSystem];

    button.frame = self.headerView.frame;
    [button addTarget:self action:@selector(imageButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

#pragma mark - Action

- (void)imageButton {
    [self netWork];
    HeaderViewController *heaerVC = [[HeaderViewController alloc] init];
    heaerVC.string = self.stringUrl;
    [self.navigationController pushViewController:heaerVC animated:YES];
}


- (void)netWork {
    [SVProgressHUD show];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *urlString = [NSString stringWithFormat:@"http://zhekou.repai.com/lws/view/zhou_if2.php"];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *IDmArray = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *nArray = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *IDArray = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *CIDArray = [NSMutableArray arrayWithCapacity:0];
        
        self.listArray = @[@"推荐", @"女人", @"美妆", @"数码", @"居家", @"零食", @"男人", @"创意"];
        NSMutableArray *tempArray = responseObject[self.listArray[self.selectedIndex]];
        for (NSDictionary *dic in tempArray) {
            [IDArray addObject:dic[@"cid"]];
            [IDmArray addObject:dic[@"cid"]];
            [nArray addObject:dic[@"name"]];
            [mArray addObject:dic[@"name"]];
        }
        //去除第一个name
        [nArray removeObjectAtIndex:0];
        //只留下第一个name
        [mArray removeObjectsInArray:nArray];
        self.nameArray = [NSMutableArray arrayWithArray:nArray];
        self.pictureArrayUrl = [NSMutableArray arrayWithArray:mArray];
        self.stringUrl = self.pictureArrayUrl[0];
        //去除第一个ID
        [IDArray removeObjectAtIndex:0];
        self.IDArray = [NSMutableArray arrayWithArray:IDArray];
        for (NSString * cid in IDArray) {
            TitleList *titleList = [[TitleList alloc] init];
            titleList.CID = cid;
            [CIDArray addObject:titleList];
        }
        self.cidPictureArray = [NSMutableArray arrayWithArray:CIDArray];
        //只留下第一个ID
        [IDmArray removeObjectsInArray:IDArray];
        for (NSString * cid in IDmArray) {
            //解析ID
            NSString *string = [NSString stringWithFormat:@"http://app.api.yijia.com/tb99/iphone/images/now_lsit/%@.png", cid];
            [self.headerView.pictureView sd_setImageWithURL:[NSURL URLWithString:string]];
        }
        
        [SVProgressHUD dismiss];
        [self.collectionView reloadData];
        [self.leftView reloadData];
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error:%@", error);
        [SVProgressHUD dismissWithError:@"加载失败"];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndex = indexPath.row;
    [self netWork];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = [UIScreen mainScreen].bounds.size;
    return (size.height - 108) / self.listArray.count;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

//tableViewCell创建
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShoppingCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    cell.nameLabel.text = self.listArray[indexPath.row];
    if (indexPath.row == self.selectedIndex) {
        cell.nameLabel.textColor = [UIColor colorWithRed:1.000 green:0.400 blue:1.000 alpha:1.000];
    } else { cell.nameLabel.textColor = [UIColor blackColor];
    }
    return cell;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.nameArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SecondShopViewController *secondVC = [[SecondShopViewController alloc] init];
//    secondVC.idString = self.IDArray[indexPath.row];
    [self.navigationController pushViewController:secondVC animated:YES];
    [secondVC release];
}

//collectionView创建
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShoppingCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithWhite:0.972 alpha:1.000];
    cell.nameLabel.text = self.nameArray[indexPath.row];
    cell.titleList = self.cidPictureArray[indexPath.row];
    return cell;
}

@end
