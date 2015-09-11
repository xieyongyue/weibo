//
//  ThemeTableViewController.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/2.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "ThemeTableViewController.h"

#import "ThemeCollectionViewCell.h"
#import "ValueShopTableViewController.h"
#import "SVProgressHUD.h"


static NSString *cellIdentifier = @"cell";

@interface ThemeTableViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) NSArray *imageNameArray;
@property (nonatomic, retain) NSMutableArray *cellArray;
@property (nonatomic, retain) NSArray *stringArray;

@end

@implementation ThemeTableViewController

#pragma mark - LifeCycle

- (void)dealloc
{
    self.imageNameArray = nil;
    self.cellArray = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"生活主题";
    [self setUpCollection];
    self.stringArray = @[@"http://jkjby.yijia.com/jkjby/view/nine_web/index.php?app_id=1066136336&app_channel=appstore", @"http://app.api.yijia.com/tb99/iphone/gotu.php?gotu=trip", @"http://m.haodou.com/app/sdk/recipe.php?do=recipeList&id=320&wf=suishengou", @"http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=get_sec_ten_two_view&id=19978&title=%E8%9C%97%E5%B1%85%E4%B9%9F%E6%B8%A9%E9%A6%A8", @"http://h5.m.taobao.com/app/cz/cost.html", @"http://zhekou.yijia.com/lws/view/zhou_cat.php"];
    self.tableView.tableFooterView = [[[UITableView alloc] init] autorelease];
}

- (void)viewWillAppear:(BOOL)animated {
    [SVProgressHUD dismiss];
}

- (void)setUpCollection {
    CGSize size = [UIScreen mainScreen].bounds.size;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //cell大小
    layout.itemSize = CGSizeMake(size.width / 4.3, size.height / 6.67);
    //分区边距(上左下右)
    layout.sectionInset = UIEdgeInsetsMake(size.height / 22.23, size.width / 6.5, size.height / 16.675, size.width / 6.5);
    //最小行间距
    layout.minimumLineSpacing = size.height / 22.23;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    [layout release];
    [collectionView release];
    //注册cell类型
    [collectionView registerClass:[ThemeCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    
    self.cellArray = [NSMutableArray array];
    self.imageNameArray = @[@"超值购", @"旅游团", @"美颜美食", @"聚家装", @"充值中心", @"每周新发现"];
    for (NSInteger i = 0; i < 6; i++) {
        NSString *title = [NSString stringWithFormat:@"%@", self.imageNameArray[i]];
        UIImage *image = [UIImage imageNamed:title];
        NSDictionary *dic = @{@"image": image, @"title":title};
        [self.cellArray addObject:dic];
        self.tableView.alwaysBounceHorizontal = YES;
    }
}

#pragma mark - UICollectionViewDataSource

//分区cell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.cellArray.count;
}

//创建cell必须使用注册方式
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ThemeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSDictionary *dic = self.cellArray[indexPath.row];
    UIImage *image = dic[@"image"];
    NSString *title = dic[@"title"];
    cell.imageView.image = image;
    cell.titleLabel.text = title;
    return cell;
}

#pragma mark - UICollectionViewDelegate

//点击了某行cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ValueShopTableViewController *valueVC = [[ValueShopTableViewController alloc] init];
        valueVC.strUrl = self.stringArray[0];
        valueVC.titleString = self.imageNameArray[0];
        [self.navigationController pushViewController:valueVC animated:YES];
        [valueVC release];
    } else if (indexPath.row == 1) {
        ValueShopTableViewController *valueVC = [[ValueShopTableViewController alloc] init];
        valueVC.strUrl = self.stringArray[1];
        valueVC.titleString = self.imageNameArray[1];
        [self.navigationController pushViewController:valueVC animated:YES];
        [valueVC release];
    } else if (indexPath.row == 2) {
        ValueShopTableViewController *valueVC = [[ValueShopTableViewController alloc] init];
        valueVC.strUrl = self.stringArray[2];
        valueVC.titleString = self.imageNameArray[2];
        [self.navigationController pushViewController:valueVC animated:YES];
        [valueVC release];
    } else if (indexPath.row == 3) {
        ValueShopTableViewController *valueVC = [[ValueShopTableViewController alloc] init];
        valueVC.strUrl = self.stringArray[3];
        valueVC.titleString = self.imageNameArray[3];
        [self.navigationController pushViewController:valueVC animated:YES];
        [valueVC release];
    } else if (indexPath.row == 4) {
        ValueShopTableViewController *valueVC = [[ValueShopTableViewController alloc] init];
        valueVC.strUrl = self.stringArray[4];
        valueVC.titleString = self.imageNameArray[4];
        [self.navigationController pushViewController:valueVC animated:YES];
        [valueVC release];
    } else if (indexPath.row == 5) {
        ValueShopTableViewController *valueVC = [[ValueShopTableViewController alloc] init];
        valueVC.strUrl = self.stringArray[5];
        valueVC.titleString = self.imageNameArray[5];
        [self.navigationController pushViewController:valueVC animated:YES];
        [valueVC release];
    }    
 }

#pragma mark - UICollectionViewDelegateFlowLayout


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITablViewDataSource
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   return self.cellArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.themeArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    ThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[ThemeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    cell.lifeThemeList = self.cellArray[indexPath.section][indexPath.row];
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
