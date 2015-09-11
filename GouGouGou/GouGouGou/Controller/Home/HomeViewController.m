//
//  HomeViewController.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/3.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "HomeViewController.h"
#import "Bottomview.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "BuyViewController.h"
#import "WorthbuyingViewController.h"
#import "HaveATryViewController.h"
#import "WebbuttonViewController.h"
#import "BuyCollectionViewCell.h"
#import "TopCollectionViewCell.h"
#import "CenterCollectionViewCell.h"
#import "NumberHandle.h"
#import "SDCycleScrollView.h"
#import "HomeDataBaseHandle.h"
#import "Goods.h"
#import "Scroltltle.h"



static NSString *topcellIdentifier = @"cell";
static NSString *centerIdentifier = @"cel";
static NSString *bottomIdentifier = @"ce";
static NSString *footerIdentifier = @"footer";

@interface HomeViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, SDCycleScrollViewDelegate>

@property(nonatomic, retain)__block NSMutableArray *scrollimagestring, *scrolllink, *scrolltitle, *listArray, *image_string,*now_price, *original_price, *discount, *titles, *goodsid;
@property(nonatomic, retain)NSArray *titleArray;
@property(nonatomic, assign)NSInteger sectionNumber;
@property(nonatomic, retain)NSString *urlstring, *labelstring;
@property(nonatomic, retain)TopCollectionViewCell *topCell;
@property(nonatomic, retain)CenterCollectionViewCell *centerCell;
@property(nonatomic, retain)BuyCollectionViewCell *bottomCell;
@end

@implementation HomeViewController

- (void)dealloc
{
    self.scrollimagestring = nil;
    self.scrolllink = nil;
    self.scrolltitle = nil;
    self.image_string = nil;
    self.now_price = nil;
    self.original_price = nil;
    self.discount = nil;
    self.titles = nil;
    self.goodsid = nil;
    self.bottomCell = nil;
    self.listArray = nil;
    self.titleArray = nil;
    self.urlstring = nil;
    self.labelstring = nil;
    self.topCell = nil;
    self.centerCell = nil;
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    HomeDataBaseHandle *handel = [HomeDataBaseHandle shareDataBaseHandle];
    [handel createScroltable];
    [handel createTable];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NumberHandle *numberHandle = [NumberHandle defaultNumberHandle];
    
    self.urlstring = [[NSString alloc] initWithFormat:@"http://zhekou.repai.com/lws/wangyu/index.php?control=babynews&model=index3&app_id=1066136336&app_oid=902661b0957a60cf42c7cc386d906a9555a6847c&app_version=2.7&app_channel=appstore&cid=%ld", (long)numberHandle.selectedIndex];
    self.titleArray = @[@"新品", @"数码", @"女装", @"男装", @"家居", @"辣妈", @"鞋包", @"配饰", @"美妆", @"美食"];
    
    
    CGSize size = [[UIScreen mainScreen] bounds].size;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0,size.width, size.height) collectionViewLayout:layout];
    
    
    [self topnetwork];
    [self network];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [layout release];
    
    //注册cell
    
    [self.collectionView registerClass:[TopCollectionViewCell class] forCellWithReuseIdentifier:topcellIdentifier];
    
    [self.collectionView registerClass:[CenterCollectionViewCell class] forCellWithReuseIdentifier:centerIdentifier];
    
    [self.collectionView registerClass:[BuyCollectionViewCell class] forCellWithReuseIdentifier:bottomIdentifier];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView release];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerIdentifier];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    

    
    
}

//bottom解析

- (void)network{
    
    self.image_string = [[NSMutableArray alloc] initWithCapacity:0];
    self.now_price = [[NSMutableArray alloc] initWithCapacity:0];
    self.original_price = [[NSMutableArray alloc] initWithCapacity:0];
    self.discount = [[NSMutableArray alloc] initWithCapacity:0];
    self.titles = [[NSMutableArray alloc] initWithCapacity:0];
    self.goodsid = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    HomeDataBaseHandle *handle2 = [HomeDataBaseHandle shareDataBaseHandle];
    [handle2 searcAlldic];
    
    NumberHandle *numberHandle = [NumberHandle defaultNumberHandle];
    //判断是否有某一个类别的东西在数据库中
    int a = 0;
    for (Goods *goods in handle2.Goodslist) {
        if ([goods.goodskind isEqualToString:self.titleArray[numberHandle.selectedIndex]]) {
            a = 1;
        }
    }
    
    if (handle2.Goodslist.count == 0 || a == 0) {
        
        //解析
        AFHTTPRequestOperationManager *manager1 = [AFHTTPRequestOperationManager manager];
        //设置支持的数据类型
        manager1.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        NSString *urlstring1 = self.urlstring;
        [manager1 GET:urlstring1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NumberHandle *numberHandle = [NumberHandle defaultNumberHandle];;
            self.listArray = responseObject[@"list"];
            for (int i = 0; i < [responseObject[@"list"] count]; i++) {
                Goods *goods = [[Goods alloc] init];
                goods.goodskind = self.titleArray[numberHandle.selectedIndex];
                goods.image_string = self.listArray[i][@"pic_url"];
                goods.now_price = self.listArray[i][@"now_price"];
                goods.original_price = self.listArray[i][@"origin_price"];
                goods.discount = self.listArray[i][@"discount"];
                goods.title = self.listArray[i][@"title"];
                goods.goodsid = self.listArray[i][@"num_iid"];
                [handle2 addGoods:goods];
                
                if ([goods.goodskind isEqualToString:self.titleArray[numberHandle.selectedIndex]]) {
                    [self.image_string addObject:goods.image_string];
                    [self.now_price addObject:goods.now_price];
                    [self.original_price addObject:goods.original_price];
                    [self.discount addObject:goods.discount];
                    [self.titles addObject:goods.title];
                    [self.goodsid addObject:goods.goodsid];
                }
                [goods release];
                
            }
            
            [self.collectionView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }else{
        for (int i = 0; i< handle2.Goodslist.count; i++) {
            Goods *goods = handle2.Goodslist[i];
            if ([goods.goodskind isEqualToString:self.titleArray[numberHandle.selectedIndex]]) {
                [self.image_string addObject:goods.image_string];
                [self.now_price addObject:goods.now_price];
                [self.original_price addObject:goods.original_price];
                [self.discount addObject:goods.discount];
                [self.titles addObject:goods.title];
                [self.goodsid addObject:goods.goodsid];
            }
            [goods release];
        }
    }
    
    
}
- (void)topnetwork{
    self.scrollimagestring =  [[NSMutableArray alloc] initWithCapacity:0];
    self.scrolllink = [[NSMutableArray alloc] initWithCapacity:0];
    self.scrolltitle = [[NSMutableArray alloc] initWithCapacity:0];
    
    HomeDataBaseHandle *handle1 = [HomeDataBaseHandle shareDataBaseHandle];
    [handle1 searcAllscroll];
    
    
    if (handle1.ScrollArray.count ==  0) {
        
        //解析
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //设置支持的数据类型
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        NSString *urlstring = @"http://cloud.repaiapp.com/yunying/spzt.php";
        [manager GET:urlstring parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            
            for (NSDictionary *dic in responseObject[@"data"]) {
                Scroltltle *scroltitle = [[Scroltltle alloc] init];
                scroltitle.imagestring = dic[@"iphoneimg"];
                scroltitle.link = dic[@"link"];
                scroltitle.title = dic[@"title"];
                [handle1 addScrol:scroltitle];
                
                [self.scrollimagestring addObject:scroltitle.imagestring];
                [self.scrolllink addObject:scroltitle.link];
                [self.scrolltitle addObject:scroltitle.title];
                
                [scroltitle release];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }else{
        for (int i = 0; i< handle1.ScrollArray.count; i++) {
            Scroltltle *scrolltitle = handle1.ScrollArray[i];
            [self.scrollimagestring addObject:scrolltitle.imagestring];
            [self.scrolllink addObject:scrolltitle.link];
            [self.scrolltitle addObject:scrolltitle.title];
            
            [scrolltitle release];
        }
    }
    
    
}
#pragma mark <UICollectionViewDataSource>

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerIdentifier forIndexPath:indexPath];
        return headerView;
    }else{
        return nil;
    }
}
//分区个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 3;
}
//添加cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 ) {
        self.topCell = [collectionView dequeueReusableCellWithReuseIdentifier:topcellIdentifier forIndexPath:indexPath];
        
        self.topCell.sdCycleScrollView.userInteractionEnabled = YES;
        self.topCell.sdCycleScrollView.delegate = self;
        NSMutableArray *imagesurlArray = [[NSMutableArray alloc] initWithCapacity:0];
        
        for (int i = 0; i < self.scrolllink.count; i++) {
            [imagesurlArray addObject:self.scrollimagestring[i]];
            
            //手势*purchaseimageview, *rechargeimageview, *lifestreetimageview, *lotteryimageview;
            
            UITapGestureRecognizer *tappurchaseimageview = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappurchaseimageview)];
            self.topCell.purchaseimageview.userInteractionEnabled = YES;
            [self.topCell.purchaseimageview addGestureRecognizer:tappurchaseimageview];
            [tappurchaseimageview release];
            
            UITapGestureRecognizer *taprechargeimageview = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taprechargeimageview)];
            self.topCell.rechargeimageview.userInteractionEnabled = YES;
            [self.topCell.rechargeimageview addGestureRecognizer:taprechargeimageview];
            [taprechargeimageview release];
            
            UITapGestureRecognizer *taplifestreetimageview = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taplifestreetimageview)];
            self.topCell.lifestreetimageview.userInteractionEnabled = YES;
            [self.topCell.lifestreetimageview addGestureRecognizer:taplifestreetimageview];
            [taplifestreetimageview release];
            
            UITapGestureRecognizer *taplotteryimageview = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taplotteryimageview)];
            self.topCell.lotteryimageview.userInteractionEnabled = YES;
            [self.topCell.lotteryimageview addGestureRecognizer:taplotteryimageview];
            [taplotteryimageview release];
            
        }
        
        self.topCell.sdCycleScrollView.imageURLStringsGroup = imagesurlArray;
        return self.topCell;
        
    }else if (indexPath.section == 1){
        self.centerCell = [collectionView dequeueReusableCellWithReuseIdentifier:centerIdentifier forIndexPath:indexPath];
        
        NumberHandle *numberHandle = [NumberHandle defaultNumberHandle];
        self.centerCell.Goodstitlelabel.text = self.titleArray[numberHandle.selectedIndex];
        //手势 *all_buy_view, *worth_to_buy_view, *tommorrow_view, *have_a_try_view
        
        UITapGestureRecognizer *tapall_buy_view = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapall_buy_view)];
        self.centerCell.all_buy_view.userInteractionEnabled = YES;
        [self.centerCell.all_buy_view addGestureRecognizer:tapall_buy_view];
        [tapall_buy_view release];
        
        UITapGestureRecognizer *tapworth_to_buy_view = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapworth_to_buy_view)];
        self.centerCell.worth_to_buy_view.userInteractionEnabled = YES;
        [self.centerCell.worth_to_buy_view addGestureRecognizer:tapworth_to_buy_view];
        [tapworth_to_buy_view release];
        
        UITapGestureRecognizer *taptommorrow_view = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taptommorrow_view)];
        self.centerCell.tommorrow_view.userInteractionEnabled = YES;
        [self.centerCell.tommorrow_view addGestureRecognizer:taptommorrow_view];
        [taptommorrow_view release];
        
        UITapGestureRecognizer *taphave_a_try_view = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taphave_a_try_view)];
        self.centerCell.have_a_try_view.userInteractionEnabled = YES;
        [self.centerCell.have_a_try_view addGestureRecognizer:taphave_a_try_view];
        [taphave_a_try_view release];
        
        return self.centerCell;
        
    }else{
        BuyCollectionViewCell *bottomCell = [collectionView dequeueReusableCellWithReuseIdentifier:bottomIdentifier forIndexPath:indexPath];
        [bottomCell.leftview.Recommondneimagewview sd_setImageWithURL:self.image_string[indexPath.row] placeholderImage:[UIImage imageNamed:@"暂无图片"]];
        bottomCell.leftview.pricelabel.text = [NSString stringWithFormat:@"￥%.1f原价:￥%.1f",[self.now_price[indexPath.row ] floatValue], [self.original_price[indexPath.row] floatValue]];
        bottomCell.leftview.titillabel.text = [NSString stringWithFormat:@"【%.1f折】%@",[self.discount[indexPath.row ] floatValue],  self.titles[indexPath.row ]];
        bottomCell.leftview.bottomimageview.userInteractionEnabled = NO;
        return  bottomCell;
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0 || section == 1) {
        return 1;
    }else{
        
        return self.image_string.count;
    }
}
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    WebbuttonViewController *controller = [[WebbuttonViewController alloc] init];
    
    controller.urlstring = self.scrolllink[index];
    controller.titlestring = self.scrolltitle[index];
    [self.navigationController pushViewController:controller animated:NO];
    [controller release];
}
#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/4 + [UIScreen mainScreen].bounds.size.height/15);
            break;
        case 1:
            return CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/5 + [UIScreen mainScreen].bounds.size.height/15);
            break;
            
        default:
            return CGSizeMake([UIScreen mainScreen].bounds.size.width/2-30, [UIScreen mainScreen].bounds.size.height/3);
            break;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0 || section == 1) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }else{
        return UIEdgeInsetsMake(0, 20, 0, 20);
    }
}
//区尾大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    if (section == 2) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 120);
    }else{
        return CGSizeZero;
    }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section > 1) {
        NumberHandle *numberHandle = [NumberHandle defaultNumberHandle];
        WebbuttonViewController *controller = [[WebbuttonViewController alloc] init];
        controller.urlstring = [[NSString alloc] initWithFormat:@"http://cloud.yijia.com/goto/item.php?app_id=1066136336&app_oid=902661b0957a60cf42c7cc386d906a9555a6847c&app_version=2.7&app_channel=appstore&id=%@&sche=fenjiujiu&nine=%ld", self.goodsid[indexPath.row], (long)numberHandle.selectedIndex];
        controller.titlestring = nil;
        
        [self.navigationController pushViewController:controller animated:NO];
    }
}

#pragma mark - middle gesture

- (void)tapall_buy_view{
    BuyViewController *controller = [[BuyViewController alloc] init];
    controller.urlstring = @"http://zhekou.repai.com/lws/model/paiming.php?lei=jkj";
    controller.titlestring = @"都在买";
    [self.navigationController pushViewController:controller animated:NO];
    
    [controller release];
}
- (void)taptommorrow_view{
    BuyViewController *controller = [[BuyViewController alloc] init];
    controller.titlestring = @"明日抢";
    controller.urlstring = @"http://jkjby.yijia.com/jkjby/view/tomorrow_api.php?app_id=1066136336&app_oid=902661b0957a60cf42c7cc386d906a9555a6847c&app_version=2.7&app_channel=appstore";
    [self.navigationController pushViewController:controller animated:NO];
    
    [controller release];
    
}
- (void)taphave_a_try_view{
    
    HaveATryViewController *controller = [[HaveATryViewController alloc] init];
    
    controller.urlstring = @"http://m.repai.com/search/search_items_api/query/%E6%89%8B%E6%9C%BA%E5%A3%B3/offset/0/limit/130/price_start/0/price_end/80/appkey/100022/app_id/1066136336";
    
    [self.navigationController pushViewController:controller animated:NO];
    
    [controller release];
}
- (void)tapworth_to_buy_view{
    WorthbuyingViewController *controller = [[WorthbuyingViewController alloc] init];
    [self.navigationController pushViewController:controller animated:NO];
    
    
}

#pragma mark - topgesture

//手势*purchaseimageview, *rechargeimageview, *lifestreetimageview, *lotteryimageview;

- (void)tappurchaseimageview{
    
    WebbuttonViewController *controller = [[WebbuttonViewController alloc] init];
    controller.urlstring = @"http://cloud.repaiapp.com/yunying/miao.php?app_id=1066136336&target=present&app_oid=&app_version=&app_channel=appstore&sche=fenjiujiu";
    controller.titlestring = @"限时抢购";
    [self.navigationController pushViewController:controller animated:NO];
    
}

- (void)taprechargeimageview{
    
    WebbuttonViewController *controller = [[WebbuttonViewController alloc] init];
    controller.urlstring = @"http://app.api.yijia.com/tb99/iphone/gotu.php?gotu=zczx";
    controller.titlestring = @"充值";
    [self.navigationController pushViewController:controller animated:NO];
    [controller release];
}
- (void)taplifestreetimageview{
    
    WebbuttonViewController *controller = [[WebbuttonViewController alloc] init];
    controller.urlstring = @"http://zhekou.yijia.com/lws/view/yijia_shop.php?app_id=1066136336&sche=fenjiujiu";
    controller.titlestring = @"生活街";
    [self.navigationController pushViewController:controller animated:NO];
    [controller release];
}
- (void)taplotteryimageview{
    WebbuttonViewController *controller = [[WebbuttonViewController alloc] init];
    controller.urlstring = @"http://888.qq.com/";
    controller.titlestring = @"彩票";
    [self.navigationController pushViewController:controller animated:NO];
    [controller release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated{
    
}

@end
