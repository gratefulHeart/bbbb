//
//  PieChartViewController.m
//  DaoGou
//
//  Created by FayuGuo on 15/7/29.
//  Copyright (c) 2015年 company. All rights reserved.
//

#import "PieChartMViewController.h"

@interface PieChartMViewController ()<ChartViewDelegate>
{
    NSArray *parties;
    NSMutableArray *experienctArray;
}
@end

@implementation PieChartMViewController
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = YES;
//}
//
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = NO;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.fd_prefersNavigationBarHidden = NO;

    
    experienctArray = [[NSMutableArray alloc]init];
    
    
    _chartView.delegate = self;
    
    _chartView.usePercentValuesEnabled = YES;
    _chartView.holeTransparent = YES;
    _chartView.centerTextFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.f];
    _chartView.holeRadiusPercent = 0.48;
    _chartView.transparentCircleRadiusPercent = 0.51;
//    _chartView.descriptionText = @"122ewqeqe";
    _chartView.drawCenterTextEnabled = YES;
    _chartView.drawHoleEnabled = YES;
    _chartView.rotationAngle = 0.0;
    _chartView.rotationEnabled = YES;
//    _chartView.centerText = @"iOS Charts\nby Daniel Cohen Gindi";
    
    ChartLegend *l = _chartView.legend;
    l.position = ChartLegendPositionRightOfChart;
    l.xEntrySpace = 7.0;
    l.yEntrySpace = 0.0;
    l.yOffset = 0.0;
    
    NSDateFormatter *formatter = [NSDateFormatter defaultDateFormatter];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateS = [formatter stringFromDate:[NSDate date]];
    
    if ([self.title isEqualToString:@"客户各皮肤类型对比图"]) {
        parties = @[@"油性皮肤", @"干性皮肤", @"中性皮肤", @"混合性皮肤", @"敏感皮肤", @"其他"];
        _chartView.centerText = @"皮肤类型";
        
//        NSMutableArray *experienctArray = [NSMutableArray array];
        for (int i =0; i<[parties count]; i++) {
            
            NSString *experienceType = [parties objectAtIndex:i];
            if ([experienceType isEqualToString:@"其他"]) {
                experienceType = @"";
            }
            
            NSString *sql = @"";
            if(self.type == AllType){
                sql = [NSString stringWithFormat:@"SELECT * FROM dg_info where %@ ='%@'",@"experienceType",experienceType];
                _chartView.descriptionText = @"根据皮肤类型统计(全部数据)";

            }
            else if (self.type == TodayType){
                sql = [NSString stringWithFormat:@"SELECT * FROM dg_info where dateStr='%@' and %@ ='%@'",dateS,@"experienceType",experienceType];
//                FMDataBaseHelper *fm = [FMDataBaseHelper shareInstance];
//                NSArray *arr = [fm queryDataBySql:sql];
//                [experienctArray addObject:arr];
                _chartView.descriptionText = @"根据皮肤类型统计(今日数据)";

            }
            
            FMDataBaseHelper *fm = [FMDataBaseHelper shareInstance];
            NSArray *arr = [fm queryDataBySql:sql];
            [experienctArray addObject:arr];
            
        }
        [self setDataArray:experienctArray];

    }
    else if ([self.title isEqualToString:@"客户消费能力各类型对比图"]){
        parties = @[@"VIP", @"首次体验", @"其他"];
        _chartView.centerText = @"消费能力";
        
//        NSMutableArray *experienctArray = [NSMutableArray array];
        for (int i =0; i<[parties count]; i++) {
            
            NSString *experienceType = [parties objectAtIndex:i];
            if ([experienceType isEqualToString:@"其他"]) {
                experienceType = @"";
            }
            
            NSString *sql = @"";
            if(self.type == AllType){
                sql = [NSString stringWithFormat:@"SELECT * FROM dg_info where %@ ='%@'",@"memberType",experienceType];
                _chartView.descriptionText = @"根据客户消费能力统计(全部数据)";
                
            }
            else if (self.type == TodayType){
                sql = [NSString stringWithFormat:@"SELECT * FROM dg_info where dateStr='%@' and %@ ='%@'",dateS,@"memberType",experienceType];
                _chartView.descriptionText = @"根据客户消费能力统计(今日数据)";
                
            }
            FMDataBaseHelper *fm = [FMDataBaseHelper shareInstance];
            NSArray *arr = [fm queryDataBySql:sql];
            [experienctArray addObject:arr];
            
        }
        [self setDataArray:experienctArray];
 
    }
    else if ([self.title isEqualToString:@"客户各消费等级对比图"]){
        parties = @[@"0-200", @"200-500", @"500-800", @"800-1200", @"1200以上", @"其他"];
        _chartView.centerText = @"消费等级";
        
//        NSMutableArray *experienctArray = [NSMutableArray array];
        for (int i =0; i<[parties count]; i++) {
            
            NSString *experienceType = [parties objectAtIndex:i];
            if ([experienceType isEqualToString:@"其他"]) {
                experienceType = @"";
            }
            
            NSString *sql = @"";
            if(self.type == AllType){
                sql = [NSString stringWithFormat:@"SELECT * FROM dg_info where %@ ='%@'",@"costAmount",experienceType];
                _chartView.descriptionText = @"根据客户消费等级统计(全部数据)";
                
            }
            else if (self.type == TodayType){
                sql = [NSString stringWithFormat:@"SELECT * FROM dg_info where dateStr='%@' and %@ ='%@'",dateS,@"costAmount",experienceType];
                _chartView.descriptionText = @"根据客户消费等级统计(今日数据)";
                
            }
            FMDataBaseHelper *fm = [FMDataBaseHelper shareInstance];
            NSArray *arr = [fm queryDataBySql:sql];
            [experienctArray addObject:arr];
            
        }
        [self setDataArray:experienctArray];

    }

//    [self setDataCount:(6) range:100];

    [_chartView animateWithXAxisDuration:1.5 yAxisDuration:1.5 easingOption:ChartEasingOptionEaseOutBack];
    
    
}

-(void)setDataArray:(NSArray *)arr
{
//    double mult = range;
    
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    
    // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
    for (int i = 0; i < [parties count]; i++)
    {
//        [yVals1 addObject:[[BarChartDataEntry alloc] initWithValue:(arc4random_uniform(mult) + mult / 5) xIndex:i]];
        [yVals1 addObject:[[BarChartDataEntry alloc] initWithValue:[[arr objectAtIndex:i] count] xIndex:i]];
    }
    
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [parties count]; i++)
    {
        [xVals addObject:parties[i % parties.count]];
//        [xVals addObject:[NSString stringWithFormat:@"%@%ld人",parties[i % parties.count],[[arr objectAtIndex:i] count]]];
    }
    
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithYVals:yVals1 label:@"Election Results"];
    dataSet.sliceSpace = 3.0;
    
    // add a lot of colors
    
    NSMutableArray *colors = [[NSMutableArray alloc] init];
//    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
//    [colors addObjectsFromArray:ChartColorTemplates.joyful];
    [colors addObjectsFromArray:ChartColorTemplates.colorful];
//    [colors addObjectsFromArray:ChartColorTemplates.liberty];
//    [colors addObjectsFromArray:ChartColorTemplates.pastel];
//    [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
    
    dataSet.colors = colors;
    
    PieChartData *data = [[PieChartData alloc] initWithXVals:xVals dataSet:dataSet];
    
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 1;
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @" %";
    [data setValueFormatter:pFormatter];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];
    [data setValueTextColor:UIColor.whiteColor];
    
    _chartView.data = data;
    [_chartView highlightValues:nil];

}
- (void)setDataCount:(int)count range:(double)range
{
    double mult = range;
    
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    
    // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
    for (int i = 0; i < count; i++)
    {
        [yVals1 addObject:[[BarChartDataEntry alloc] initWithValue:(arc4random_uniform(mult) + mult / 5) xIndex:i]];
    }
    
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        [xVals addObject:parties[i % parties.count]];
    }
    
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithYVals:yVals1 label:@"Election Results"];
    dataSet.sliceSpace = 3.0;
    
    // add a lot of colors
    
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
    [colors addObjectsFromArray:ChartColorTemplates.joyful];
    [colors addObjectsFromArray:ChartColorTemplates.colorful];
    [colors addObjectsFromArray:ChartColorTemplates.liberty];
    [colors addObjectsFromArray:ChartColorTemplates.pastel];
    [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
    
    dataSet.colors = colors;
    
    PieChartData *data = [[PieChartData alloc] initWithXVals:xVals dataSet:dataSet];
    
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 1;
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @" %";
    [data setValueFormatter:pFormatter];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];
    [data setValueTextColor:UIColor.whiteColor];
    
    _chartView.data = data;
    [_chartView highlightValues:nil];
}
#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry dataSetIndex:(NSInteger)dataSetIndex highlight:(ChartHighlight * __nonnull)highlight
{
 
    NSArray *marr = [experienctArray objectAtIndex:entry.xIndex];
   NSString *title  = [NSString stringWithFormat:@"%@  %ld人",[parties objectAtIndex:entry.xIndex],[marr count]];
    UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"提示" message:title delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
    [al show];
    
//    NSLog(@"%@str = %@\n====%@===%ld====%@",experienctArray,str,entry,dataSetIndex,highlight);
    NSLog(@"chartValueSelected");
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
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
