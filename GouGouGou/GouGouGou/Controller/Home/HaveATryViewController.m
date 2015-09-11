//
//  HaveATryViewController.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/9.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "HaveATryViewController.h"
#import "BuyCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "Bottomview.h"
#import "AFNetworking.h"
#import "SVPullToRefresh.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "WebbuttonViewController.h"
#import "MJRefresh.h"
static NSString *cellIdentifier = @"cell";
@interface HaveATryViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation HaveATryViewController

- (void)dealloc
{
    self.listArray = nil;
    self.urlstring = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [SVProgressHUD dismiss];
    self.navigationItem.title = @"试试手气";
    
    [SVProgressHUD show];
    //解析
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //设置支持的数据类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *urlstring = self.urlstring;
    [manager GET:urlstring parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        self.listArray = [[NSArray alloc] initWithArray:responseObject[@"data"]];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/2-30, [UIScreen mainScreen].bounds.size.height/3);
        layout.minimumInteritemSpacing = 20;
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 20, 15);
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:collectionView];
        [layout release];
        //下拉刷新
        collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self viewDidLoad];
            [collectionView.header endRefreshing];
        }];
        
        //注册cell
        [collectionView registerClass:[BuyCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        [collectionView release];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        NSLog(@"错了%@", error);
    }];
    
    
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    BuyCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [cell.leftview.Recommondneimagewview sd_setImageWithURL:self.listArray[indexPath.row][@"rp_pic_url_hd"]placeholderImage:[UIImage imageNamed:@"暂无图片"]];
    
    NSString *string1 = self.listArray[indexPath.row][@"rp_old_price"];

    NSString *string2 = self.listArray[indexPath.row ][@"rp_discount"];
    
    cell.leftview.pricelabel.text = [NSString stringWithFormat:@"￥%.1f原价:￥%@",[string1 floatValue] * [string2 floatValue] / 10, self.listArray[indexPath.row][@"rp_old_price"]];
    cell.leftview.titillabel.text = [NSString stringWithFormat:@"【%@折】%@",self.listArray[indexPath.row ][@"rp_discount"],  self.listArray[indexPath.row ][@"rp_title"]];
    

    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return self.listArray.count;
    
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WebbuttonViewController *controller = [[WebbuttonViewController alloc] init];
    controller.urlstring = [[NSString alloc] initWithFormat:@"http://cloud.yijia.com/goto/item.php?app_id=1066136336&app_oid=902661b0957a60cf42c7cc386d906a9555a6847c&app_version=2.7&app_channel=appstore&id=%@&sche=fenjiujiu&nine=1", self.listArray[indexPath.row][@"rp_iid"]];
    controller.titlestring = nil;
    
    [self.navigationController pushViewController:controller animated:YES];
    
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
