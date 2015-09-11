//
//  GoodViewController.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/11.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "GoodViewController.h"
#import "AFNetworking.h"
#import "TitleList.h"
#import "SVPullToRefresh.h"
#import "GoodCollectionViewCell.h"
#import "SVProgressHUD.h"
#import "DetailViewController.h"

static NSString *cellIdentifier = @"Cell";
@interface GoodViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//用于存放TitleList对象
@property (nonatomic, retain) NSMutableArray *listArray, *detailUrlArray;
@property (nonatomic, assign) NSInteger page;//页数

@end

@implementation GoodViewController

#pragma mark - LifeCycle

- (void)dealloc
{
    self.collectionVIew = nil;
    self.listArray = nil;
    self.detailUrlArray = nil;
    self.idString = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"女神的新衣";
    self.page = 1;
    [self netWork];
    //添加下拉加载最新数据
    [self.collectionVIew addPullToRefreshWithActionHandler:^{
        self.page = 1;
        [self netWork];
    }];
    //添加上拉加载最新数据
    [self.collectionVIew addInfiniteScrollingWithActionHandler:^{
        self.page++;
        [self netWork];
    }];
    [SVProgressHUD show];

}

- (void)netWork {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *urlString = [NSString stringWithFormat:@"http://app.api.yijia.com/newapps/gsc/api/mshop.php?model=data&id=%@&start=1", self.idString];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *tempArray = responseObject;
        //创建临时的数据mArray存储当前页的数据
        NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:0];
        //创建临时的数组nArray存储当前页的图片详细地址数据
        NSMutableArray *nArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in tempArray) {
            TitleList *titleList = [[TitleList alloc] init];
            titleList.title = dic[@"title"];
            titleList.discount = [NSString stringWithFormat:@"【%@折】", dic[@"discount"]];
            titleList.pictureName = dic[@"pic_url"];
            titleList.now_price = dic[@"now_price"];
            titleList.origin_price = dic[@"origin_price"];
            [nArray addObject:dic[@"num_iid"]];
            [mArray addObject:titleList];
            [titleList release];
        }
        
        if (self.page == 1) {
            self.listArray = [NSMutableArray arrayWithArray:mArray];
            self.detailUrlArray = [NSMutableArray arrayWithArray:nArray];
            [self.collectionVIew.pullToRefreshView stopAnimating];
        } else {
            [self.listArray addObjectsFromArray:mArray];
            [self.detailUrlArray addObjectsFromArray:nArray];
            [self.collectionVIew.infiniteScrollingView stopAnimating];
        }
        CGSize size = [UIScreen mainScreen].bounds.size;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //cell大小
        layout.itemSize = CGSizeMake(size.width / 2.5, size.height / 3.2);
        //分区边距(上左下右)
        layout.sectionInset = UIEdgeInsetsMake(10, size.width / 15, size.height / 16, size.width / 15);
        //最小行间距
//        layout.minimumLineSpacing = size.height / 15;
        layout.minimumInteritemSpacing = size.width / 17;
        layout.footerReferenceSize = CGSizeMake(0, 80);
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [self.view addSubview:collectionView];
        [layout release];
        [collectionView release];
        //注册cell类型
        [collectionView registerClass:[GoodCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        [SVProgressHUD dismiss];
        [self.collectionVIew reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error:%@", error);
        [SVProgressHUD dismissWithError:@"加载失败"];
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.titleList = self.listArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.detailUrl = [NSString stringWithFormat:@"http://h5.m.taobao.com/awp/core/detail.htm?id=%@&sche=fen_nine_anzhong",  self.detailUrlArray[indexPath.row]];
    NSLog(@"%@",detailVC.detailUrl);
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
