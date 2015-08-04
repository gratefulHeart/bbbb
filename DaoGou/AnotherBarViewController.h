//
//  AnotherBarViewController.h
//  DaoGou
//
//  Created by FayuGuo on 15/7/29.
//  Copyright (c) 2015年 company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Charts/Charts.h>

@interface AnotherBarViewController : UIViewController
@property (weak, nonatomic) IBOutlet BarChartView *chartView;
@property (nonatomic, strong) IBOutlet NSArray *options;
@property(nonatomic)StatisticsType type;
@end
