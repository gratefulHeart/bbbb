//
//  AnotherBarViewController.m
//  DaoGou
//
//  Created by FayuGuo on 15/7/29.
//  Copyright (c) 2015年 company. All rights reserved.
//

#import "AnotherBarViewController.h"
#import <Charts/Charts.h>

@interface AnotherBarViewController ()<ChartViewDelegate>

@end

@implementation AnotherBarViewController
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = NO;
//}
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = YES;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = NO;

    // Do any additional setup after loading the view from its nib.
//    NSDateFormatter *fm = [NSDateFormatter defaultDateFormatter];
//    [fm setDateFormat:@"yyyy-MM-dd"];
//    if (self.type == TodayType) {
//        self.title = [NSString stringWithFormat:@"%@当天%@",[fm stringFromDate:[NSDate date]],self.title];
//    }
//    else
//    {
//        self.title = [NSString stringWithFormat:@"截止到%@ %@",[fm stringFromDate:[NSDate date]],self.title];
//    }
    
    
    self.options = @[
                     @{@"key": @"toggleValues", @"label": @"Toggle Values"},
                     @{@"key": @"toggleHighlight", @"label": @"Toggle Highlight"},
                     @{@"key": @"toggleHighlightArrow", @"label": @"Toggle Highlight Arrow"},
                     @{@"key": @"animateX", @"label": @"Animate X"},
                     @{@"key": @"animateY", @"label": @"Animate Y"},
                     @{@"key": @"animateXY", @"label": @"Animate XY"},
                     @{@"key": @"toggleStartZero", @"label": @"Toggle StartZero"},
                     @{@"key": @"saveToGallery", @"label": @"Save to Camera Roll"},
                     @{@"key": @"togglePinchZoom", @"label": @"Toggle PinchZoom"},
                     ];
    
    _chartView.delegate = self;
    
    _chartView.descriptionText = @"";
    _chartView.noDataTextDescription = @"You need to provide data for the chart.";

//    _chartView.drawBarShadowEnabled = NO;
//    _chartView.drawValueAboveBarEnabled = YES;
//    
//    _chartView.maxVisibleValueCount = 60;
//    _chartView.pinchZoomEnabled = NO;
//    _chartView.drawGridBackgroundEnabled = NO;
    
    _chartView.maxVisibleValueCount = 60;
    _chartView.pinchZoomEnabled = NO;
    _chartView.drawBarShadowEnabled = NO;
    _chartView.drawGridBackgroundEnabled = NO;

    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.spaceBetweenLabels = 0.0;
    xAxis.drawGridLinesEnabled = NO;
    
    _chartView.leftAxis.drawGridLinesEnabled = NO;
    _chartView.rightAxis.drawGridLinesEnabled = NO;
    
    _chartView.legend.enabled = NO;
    
    
//    _sliderX.value = 9.0;
//    _sliderY.value = 100.0;
//    @"进店客户与购买用户的对比图",@"各消费时段人流量"
    if ([self.title isEqualToString:@"进店客户与购买用户的对比图"]) {
        
        FMDataBaseHelper *fmdb = [FMDataBaseHelper shareInstance];
        NSDateFormatter *formatter = [NSDateFormatter defaultDateFormatter];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateS = [formatter stringFromDate:[NSDate date]];
        if (self.type == AllType) {
            
            NSArray * allInCustomer = [fmdb queryDataBySql:[NSString stringWithFormat:@"SELECT * FROM dg_info"]];
            NSArray * allBuyCustomer = [fmdb queryDataBySql:[NSString stringWithFormat:@"SELECT * FROM dg_info where %@!='%@'",@"costAmount",@""]];
            
            [self setOneDataCount:@[[NSString stringWithFormat:@"%ld",[allInCustomer count]],[NSString stringWithFormat:@"%ld",[allBuyCustomer count]]]];
        }
        else if(self.type == TodayType){
            NSArray * allInCustomer = [fmdb queryDataBySql:[NSString stringWithFormat:@"SELECT * FROM dg_info where %@='%@'",@"dateStr",dateS]];
            NSArray * allBuyCustomer = [fmdb queryDataBySql:[NSString stringWithFormat:@"SELECT * FROM dg_info where %@='%@' and %@!='%@'",@"dateStr",dateS,@"costAmount",@""]];
            
            [self setOneDataCount:@[[NSString stringWithFormat:@"%ld",[allInCustomer count]],[NSString stringWithFormat:@"%ld",[allBuyCustomer count]]]];
            
        }

    }
    else if([self.title isEqualToString:@"各消费时段人流量"]){
    
        FMDataBaseHelper *fmdb = [FMDataBaseHelper shareInstance];
        NSDateFormatter *formatter = [NSDateFormatter defaultDateFormatter];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateS = [formatter stringFromDate:[NSDate date]];
        
        if (self.type == AllType) {
        
            NSMutableArray *dataArr = [NSMutableArray array];
            for (int i =0; i<15; i++) {
                
                NSString *timeStr = [NSString stringWithFormat:@"%% %@%%",(i+8<10)?[NSString stringWithFormat:@"0%d",i+8]:[NSString stringWithFormat:@"%d",i+8]];
                NSString *sql = [NSString stringWithFormat:@"SELECT * FROM dg_info where %@ like'%@'",@"goinTime",timeStr];
                NSArray * arrList = [fmdb queryDataBySql:sql];
                [dataArr addObject:arrList];
            }
            
            [self setTwoDataCount:dataArr];
        }
        else if (self.type == TodayType){
            
            NSMutableArray *dataArr = [NSMutableArray array];
            for (int i =0; i<15; i++) {

                NSString *timeStr = [NSString stringWithFormat:@"%@ %@%%",dateS,(i+8<10)?[NSString stringWithFormat:@"0%d",i+8]:[NSString stringWithFormat:@"%d",i+8]];
                NSString *sql = [NSString stringWithFormat:@"SELECT * FROM dg_info where %@ like'%@'",@"goinTime",timeStr];
                NSArray * arrList = [fmdb queryDataBySql:sql];
                [dataArr addObject:arrList];
            }
            
            [self setTwoDataCount:dataArr];
        }
        
    }
    
}

- (void)setTwoDataCount:(NSArray *)array
{
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [array count]; i++)
    {
//                double mult = (100+ 1);
//                double val = (double) (arc4random_uniform(mult)) + mult / 3.0;
        NSArray  *arrr = [array objectAtIndex:i];
//        int val = [[array count] intValue];
//        [yVals addObject:[[BarChartDataEntry alloc] initWithValue:[arrr count] xIndex:i]];
        [yVals addObject:[[BarChartDataEntry alloc] initWithValue:[arrr count] xIndex:i]];

    }
    
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < [array count]; i++)
    {
//        [xVals addObject:[@((int)((BarChartDataEntry *)yVals[i]).value) stringValue]];
        [xVals addObject:[NSString stringWithFormat:@"%d:00",i+8]];
        
    }
    
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithYVals:yVals label:@"DataSet"];
    set1.colors = ChartColorTemplates.vordiplom;
    set1.drawValuesEnabled = YES;
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    
    BarChartData *data = [[BarChartData alloc] initWithXVals:xVals dataSets:dataSets];
    _chartView.data = data;
    
}


- (void)setOneDataCount:(NSArray *)array
{
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    
    
    for (int i = 0; i < [array count]; i++)
    {
//        double mult = (range + 1);
//        double val = (double) (arc4random_uniform(mult)) + mult / 3.0;
        double val = [[array objectAtIndex:i] doubleValue];
        [yVals addObject:[[BarChartDataEntry alloc] initWithValue:val xIndex:i]];
    }
    
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < [array count]; i++)
    {
        //        [xVals addObject:[@((int)((BarChartDataEntry *)yVals[i]).value) stringValue]];
//        [xVals addObject:[NSString stringWithFormat:@"%d:00",i+8]];
        if (i ==0) {
            [xVals addObject:[NSString stringWithFormat:@"%@",@"进店客户"]];
        }
        else
        {
            [xVals addObject:[NSString stringWithFormat:@"%@",@"购买用户"]];
        }
        
    }
    
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithYVals:yVals label:@"DataSet"];
    set1.colors = ChartColorTemplates.vordiplom;
    set1.drawValuesEnabled = YES;
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    
    BarChartData *data = [[BarChartData alloc] initWithXVals:xVals dataSets:dataSets];
    _chartView.data = data;

}

- (void)setDataCount:(int)count range:(double)range
{
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double mult = (range + 1);
        double val = (double) (arc4random_uniform(mult)) + mult / 3.0;
        [yVals addObject:[[BarChartDataEntry alloc] initWithValue:val xIndex:i]];
    }
    
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i++)
    {
//        [xVals addObject:[@((int)((BarChartDataEntry *)yVals[i]).value) stringValue]];
        [xVals addObject:[NSString stringWithFormat:@"%d:00",i+8]];

    }
    
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithYVals:yVals label:@"DataSet"];
    set1.colors = ChartColorTemplates.vordiplom;
    set1.drawValuesEnabled = YES;
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    
    BarChartData *data = [[BarChartData alloc] initWithXVals:xVals dataSets:dataSets];
    
    _chartView.data = data;
}
#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry dataSetIndex:(NSInteger)dataSetIndex highlight:(ChartHighlight * __nonnull)highlight
{
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
