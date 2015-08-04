//
//  PieChartViewController.h
//  DaoGou
//
//  Created by FayuGuo on 15/7/29.
//  Copyright (c) 2015年 company. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Charts;
#import <Charts/Charts.h>

@interface PieChartMViewController : UIViewController

@property (weak, nonatomic) IBOutlet PieChartView *chartView;
@property(nonatomic)StatisticsType type;

@end
