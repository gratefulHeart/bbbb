//
//  ClassificationStatisticsViewController.m
//  DaoGou
//
//  Created by FayuGuo on 15/7/30.
//  Copyright (c) 2015年 company. All rights reserved.
//

#import "ClassificationStatisticsViewController.h"
#import "PieChartMViewController.h"
#import "AnotherBarViewController.h"
@interface ClassificationStatisticsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    NSArray *dataArray;
    
}
@end

@implementation ClassificationStatisticsViewController
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = NO;
//}
//-(void)viewDidDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = YES;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.fd_prefersNavigationBarHidden = NO;

    if (_type == AllType) {
        self.title = @"分类统计(所有数据)";

    }
    else if (_type == TodayType){
        self.title = @"分类统计(今日数据)";
    }
    self.view.backgroundColor = [UIColor whiteColor];
//    UIView *vv = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
//    vv.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:vv];
    
    
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:vv.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(15, 15)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = vv.bounds;
//    maskLayer.path = maskPath.CGPath;
//    maskLayer.borderWidth = 2;
//    maskLayer.borderColor = [UIColor redColor].CGColor;
////    maskLayer.masksToBounds = YES;
//    vv.layer.mask = maskLayer;
    
    
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    
    dataArray = @[@"进店客户与购买用户的对比图",@"各消费时段人流量",@"客户消费能力各类型对比图",@"客户各皮肤类型对比图",@"客户各消费等级对比图"];
    
}
#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
    }
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.row<=1) {
        AnotherBarViewController *anotherVC = [[AnotherBarViewController alloc]init];
        anotherVC.title = [dataArray objectAtIndex:indexPath.row];
        anotherVC.type = self.type;
        [self.navigationController pushViewController:anotherVC animated:YES];
    }
    else
    {
        PieChartMViewController *PieVC = [[PieChartMViewController alloc]init];
        PieVC.title = [dataArray objectAtIndex:indexPath.row];
        PieVC.type = self.type;
        [self.navigationController pushViewController:PieVC animated:YES];
    }

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
