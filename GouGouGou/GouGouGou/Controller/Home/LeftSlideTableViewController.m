//
//  LeftSlideTableViewController.m
//  GouGouGou
//
//  Created by lanouhn on 15/7/2.
//  Copyright (c) 2015年 lanouhn Co.Ltd. All rights reserved.
//

#import "LeftSlideTableViewController.h"
#import "LeftsliderTableViewCell.h"
#import "HomeViewController.h"
#import "RootTabBarController.h"
#import "NumberHandle.h"
@interface LeftSlideTableViewController ()<UITableViewDataSource>
@property(nonatomic, assign)NSInteger previousRow;

@end

@implementation LeftSlideTableViewController

- (void)dealloc
{
    self.drawer = nil;
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    
    UILabel *headlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 2, 64)];
    [self.view addSubview:headlabel];
    headlabel.text = @"商品类目";
    headlabel.textAlignment = NSTextAlignmentCenter;
    [headlabel release];
    
   
 
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tableview datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return 11;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    //侧边栏图片
    NSMutableArray *imagearray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 1; i < 11; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d", i]];
        [imagearray addObject:image];
    }
    
    //侧边栏标题
    NSArray *titleArray = @[@"新品", @"数码", @"女装", @"男装", @"家居", @"辣妈", @"鞋包", @"配饰", @"美妆", @"美食"];
    
    static NSString *identifier = @"cell";
    LeftsliderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[LeftsliderTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier] autorelease];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.row == 0) {
        cell.detaillabel.text = nil;
        cell.titillabel.text = nil;
        cell.sliderimageview = nil;
        
    }else{
        cell.detaillabel.text = @"＞";
        cell.titillabel.text = titleArray[indexPath.row - 1];
        cell.sliderimageview.image = imagearray[indexPath.row - 1];
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = [UIColor colorWithWhite:0.902 alpha:0.500];
        }
    }
    
    
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 64;
    }else{
        return ([UIScreen mainScreen].bounds.size.height - 64)/10;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    if (indexPath > 0&&indexPath.row) {
        NumberHandle *numberHandle = [NumberHandle defaultNumberHandle];
        
        if (indexPath.row - 1 == numberHandle.selectedIndex) {
            [self.drawer close];
        }
        
        else{
            numberHandle.selectedIndex = indexPath.row - 1;
            
            [self.drawer reloadCenterViewControllerUsingBlock:^{
                [self.drawer.centerViewController viewDidLoad];
                
            }];
            
        }
    }
}

#pragma mark - Configuring the view’s layout behavior

- (UIStatusBarStyle)preferredStatusBarStyle
{
    // Even if this view controller hides the status bar, implementing this method is still needed to match the center view controller's
    // status bar style to avoid a flicker when the drawer is dragged and then left to open.
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - ICSDrawerControllerPresenting

- (void)drawerControllerWillOpen:(ICSDrawerController *)drawerController{
    self.view.userInteractionEnabled = NO;
}

- (void)drawerControllerDidOpen:(ICSDrawerController *)drawerController{
    self.view.userInteractionEnabled = YES;
}

- (void)drawerControllerWillClose:(ICSDrawerController *)drawerController{
    self.view.userInteractionEnabled = NO;
}

- (void)drawerControllerDidClose:(ICSDrawerController *)drawerController{
    self.view.userInteractionEnabled = YES;
}

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
