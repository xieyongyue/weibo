//
//  WorthbuyingViewController.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/8.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "WorthbuyingViewController.h"
#import "BuyCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "SVPullToRefresh.h"
#import "Bottomview.h"
#import "WebbuttonViewController.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"
static NSString *cellIdentifier = @"cell";



@interface WorthbuyingViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, retain)NSArray *listArray;
@property(nonatomic, retain)NSMutableArray *itemArray;
@property(nonatomic, retain)NSString *urlstring1;
@property(nonatomic, retain)UICollectionView *collectionView;

@end

@implementation WorthbuyingViewController

- (void)dealloc
{

    self.listArray = nil;
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //toolbar
    [SVProgressHUD dismiss];
    self.navigationItem.title = @"值得买";
    
    self.urlstring1 = @"http://jkjby.yijia.com/jkjby/view/tmzk19_9_api.php?cid=0";
  
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/2-30, [UIScreen mainScreen].bounds.size.height/3);
    layout.minimumInteritemSpacing = 20;
    layout.sectionInset = UIEdgeInsetsMake(0, 15, 20, 15);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 104, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    
    [layout release];
    
    
    //注册
    [self.collectionView registerClass:[BuyCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    //滚动滑块
    NSArray *array = @[@"新品", @"数码", @"女装", @"男装", @"家居", @"辣妈", @"鞋包", @"配饰", @"美妆", @"美食", @"其他"];
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:array];
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 40)];
    scrollview.alwaysBounceVertical = NO;
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.contentSize = CGSizeMake(440, 40);
    segmentControl.frame = CGRectMake(0, 0, 440, 40);
    scrollview.backgroundColor = [UIColor whiteColor];
    [scrollview addSubview:segmentControl];
    segmentControl.selectedSegmentIndex = 0;

 
    [segmentControl addTarget:self action:@selector(switchOvew:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:scrollview];
    [segmentControl release];
    [scrollview release];
    
    [self network];
    [self.view addSubview:self.collectionView];
    [self.collectionView release];
    
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self network];
        [self.collectionView.header endRefreshing];
    }];
    
}

- (void)network{
    
    [SVProgressHUD show];
    //解析
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //设置支持的数据类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:self.urlstring1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        self.listArray = [[NSArray alloc] initWithArray:responseObject[@"list"]];
        

        
        [self.collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败" duration:5];
        NSLog(@"错了%@", error);
    }];
   
}

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BuyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell.leftview.Recommondneimagewview sd_setImageWithURL:self.listArray[indexPath.row][@"pic_url"]placeholderImage:[UIImage imageNamed:@"暂无图片"]];
    
    cell.leftview.pricelabel.text = [NSString stringWithFormat:@"￥%@原价:￥%@",self.listArray[indexPath.row ][@"now_price"], self.listArray[indexPath.row][@"origin_price"]];
    cell.leftview.titillabel.text = [NSString stringWithFormat:@"【%@折】%@",self.listArray[indexPath.row ][@"discount"],  self.listArray[indexPath.row ][@"title"]];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.listArray.count;
}




#pragma mark - pressitem

- (void)switchOvew:(UISegmentedControl *)aSegmentControl{
    
    
    switch (aSegmentControl.selectedSegmentIndex) {
        case 0:
            self.urlstring1 = @"http://jkjby.yijia.com/jkjby/view/tmzk19_9_api.php?cid=0";
            
            [self network];
            break;
        case 1:
            self.urlstring1 = @"http://jkjby.yijia.com/jkjby/view/tmzk19_9_api.php?cid=1";
     
            [self network];
            break;
        case 2:
            self.urlstring1 = @"http://jkjby.yijia.com/jkjby/view/tmzk19_9_api.php?cid=2";
           [self network];
            break;
        case 3:
            self.urlstring1 = @"http://jkjby.yijia.com/jkjby/view/tmzk19_9_api.php?cid=3";
         [self network];
            break;
        case 4:
            self.urlstring1 = @"http://jkjby.yijia.com/jkjby/view/tmzk19_9_api.php?cid=4";
            [self network];
            break;
        case 5:
            self.urlstring1 = @"http://jkjby.yijia.com/jkjby/view/tmzk19_9_api.php?cid=5";
            [self network];
            break;
        case 6:
            self.urlstring1 = @"http://jkjby.yijia.com/jkjby/view/tmzk19_9_api.php?cid=6";
            [self network];
            break;
        case 7:
            self.urlstring1 = @"http://jkjby.yijia.com/jkjby/view/tmzk19_9_api.php?cid=7";
            [self network];
            break;
        case 8:
            self.urlstring1 = @"http://jkjby.yijia.com/jkjby/view/tmzk19_9_api.php?cid=8";
            [self network];
            break;
        case 9:
            self.urlstring1 = @"http://jkjby.yijia.com/jkjby/view/tmzk19_9_api.php?cid=9";
            [self network];
            break;
        case 10:
            self.urlstring1 = @"http://jkjby.yijia.com/jkjby/view/tmzk19_9_api.php?cid=10";
            [self network];
            break;
            
        default:
        break;
    }
    
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    WebbuttonViewController *controller = [[WebbuttonViewController alloc] init];
    controller.urlstring = [[NSString alloc] initWithFormat:@"http://cloud.yijia.com/goto/item.php?app_id=1066136336&app_oid=902661b0957a60cf42c7cc386d906a9555a6847c&app_version=2.7&app_channel=appstore&id=%@&sche=fenjiujiu&nine=1", self.listArray[indexPath.row][@"num_iid"]];
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
