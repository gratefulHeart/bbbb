//
//  RootVViewController.m
//  DaoGou
//
//  Created by FayuGuo on 15/7/18.
//  Copyright (c) 2015年 company. All rights reserved.
//

#import "RootVViewController.h"
#import "StaticViewController.h"
#import "BBFlashCtntLabel.h"
#import "ExportViewController.h"

#import "ImportViewController.h"
#import "ClassificationStatisticsViewController.h"

@interface RootVViewController ()

@end

@implementation RootVViewController
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
//    
//}
-(void)aaa
{
    
    
//    NSString *str = @"欢迎你😄郭发玉(先生/女士) ^_^使用统计APP来统计信息！👿";
    NSString *str = [NSString stringWithFormat:@"欢迎你😄%@ (先生/女士)^_^使用统计APP来统计信息！👿",self.userName];//;@"欢迎你😄郭发玉 ^_^使用统计APP来统计信息！👿";

    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:str];
    [att addAttribute:NSForegroundColorAttributeName
                value:[UIColor whiteColor]
                range:NSMakeRange(0, 5)];
    [att addAttribute:NSFontAttributeName
                value:[UIFont systemFontOfSize:30]
                range:NSMakeRange(5, [self.userName length])];
//    [att addAttribute:NSBackgroundColorAttributeName
//                value:[UIColor cyanColor]
//                range:NSMakeRange(0, 15)];
    [att addAttribute:NSForegroundColorAttributeName
                value:[UIColor whiteColor]
                range:NSMakeRange(5+[self.userName length], 25)];
    [att addAttribute:NSForegroundColorAttributeName
                value:[UIColor redColor]
                range:NSMakeRange(5, [self.userName length])];
    
    
    CGRect rect = CGRectMake(0, 20, SCREEN_WIDTH, 44);
    BBFlashCtntLabel *lbl = [[BBFlashCtntLabel alloc] initWithFrame:rect];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.leastInnerGap = 50.f;
    lbl.repeatCount = 0;
    lbl.speed = BBFlashCtntSpeedSlow;
//    lbl.text = str;
    lbl.attributedText = att;

    lbl.font = [UIFont systemFontOfSize:25];
    lbl.textColor = [UIColor whiteColor];
    [self.view addSubview:lbl];

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@  scale = %f",[UIScreen mainScreen],[UIScreen mainScreen].scale);
    self.fd_interactivePopDisabled = YES;
    self.fd_prefersNavigationBarHidden = YES;

    UIImageView *imgv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pad_bg.jpg"]];
    [self.view addSubview:imgv];
    [imgv mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(self.view.bounds.size);
    }];
    [self aaa];

    UIImageView *centerImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"center_bg"]];
    centerImgV.userInteractionEnabled = YES;
    centerImgV.frame = CGRectMake(20, 100, SCREEN_WIDTH-40, SCREEN_HEIGHT-200);
    [self.view addSubview:centerImgV];
    
    UIButton *todayBtn  = [UIButton buttonWithType:UIButtonTypeSystem];
    [todayBtn setFrame:CGRectMake((centerImgV.frame.size.width/3.0)/4.0, 20, (centerImgV.frame.size.width/3.0), centerImgV.frame.size.height/3.0)];
    todayBtn.layer.cornerRadius = 15.0f;
    todayBtn.layer.masksToBounds = YES;
    
    [todayBtn setBackgroundColor:[UIColor whiteColor]];
    [todayBtn setTitle:@"今日数据" forState:UIControlStateNormal];
    [todayBtn addTarget:self action:@selector(todayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [centerImgV addSubview:todayBtn];
    

    UIButton *staticBtn  = [UIButton buttonWithType:UIButtonTypeSystem];
    [staticBtn setFrame:CGRectMake((centerImgV.frame.size.width/4.0)+(centerImgV.frame.size.width/3.0), 20, centerImgV.frame.size.width/3.0, centerImgV.frame.size.height/3.0)];

    [staticBtn setBackgroundColor:[UIColor whiteColor]];
    [staticBtn setTitle:@"统计数据" forState:UIControlStateNormal];
    staticBtn.layer.masksToBounds = YES;
    staticBtn.layer.cornerRadius = 15.f;

    [staticBtn addTarget:self action:@selector(staticBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [centerImgV addSubview:staticBtn];

    UIButton *daoOutBtn  = [UIButton buttonWithType:UIButtonTypeSystem];
    [daoOutBtn setFrame:CGRectMake((centerImgV.frame.size.width/3.0)/4.0, CGRectGetHeight(centerImgV.frame)-(centerImgV.frame.size.height/3.0)-20, (centerImgV.frame.size.width/3.0), centerImgV.frame.size.height/3.0)];
    [daoOutBtn setBackgroundColor:[UIColor whiteColor]];
    [daoOutBtn setTitle:@"导出" forState:UIControlStateNormal];
    daoOutBtn.layer.cornerRadius = 15.0f;
    daoOutBtn.layer.masksToBounds = YES;
    [daoOutBtn addTarget:self action:@selector(daoOutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [centerImgV addSubview:daoOutBtn];
    
    UIButton *daoInBtn  = [UIButton buttonWithType:UIButtonTypeSystem];
    [daoInBtn setFrame:CGRectMake((centerImgV.frame.size.width/3.0)/4.0*3+(centerImgV.frame.size.width/3.0), CGRectGetHeight(centerImgV.frame)-(centerImgV.frame.size.height/3.0)-20, (centerImgV.frame.size.width/3.0), centerImgV.frame.size.height/3.0)];

    daoInBtn.layer.cornerRadius = 15.0f;
    daoInBtn.layer.masksToBounds = YES;
    [daoInBtn setBackgroundColor:[UIColor whiteColor]];
    [daoInBtn setTitle:@"导入" forState:UIControlStateNormal];
    [daoInBtn addTarget:self action:@selector(daoInBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [centerImgV addSubview:daoInBtn];
    

    UIImage *goIn = [UIImage imageNamed:@"goIn_bg"];
    UIButton *goInBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [goInBt setBackgroundImage:goIn forState:UIControlStateNormal];
    goInBt.frame = CGRectMake(0, 0, (centerImgV.frame.size.width/3.0), (centerImgV.frame.size.width/3.0));
    goInBt.center = CGPointMake(centerImgV.frame.size.width/2.0, centerImgV.frame.size.height/2.0);
    [goInBt addTarget:self action:@selector(goInBtClick:) forControlEvents:UIControlEventTouchUpInside];
    [centerImgV addSubview:goInBt];
    
}

-(void)todayBtnClick:(UIButton *)b
{
    ClassificationStatisticsViewController *classVC = [[ClassificationStatisticsViewController alloc]init];
    classVC.type = TodayType;
    
    [self.navigationController pushViewController:classVC animated:YES];
}
-(void)goInBtClick:(UIButton *)b
{
    NSDateFormatter *formatter = [NSDateFormatter dateFormatter];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dd = [formatter stringFromDate:[NSDate date]];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *beforeDate = [formatter dateFromString:[NSString stringWithFormat:@"%@ %@",dd,@"08:00:00"]];
    NSDate *afterDate = [formatter dateFromString:[NSString stringWithFormat:@"%@ %@",dd,@"22:00:00"]];

    if ([[NSDate date]isLaterThanDate:beforeDate]&&[[NSDate date] isEarlierThanDate:afterDate]) {
        NSString *timeStr = [formatter stringFromDate:[NSDate date]];
        NSLog(@"timeStr = = %@",timeStr);
        StaticViewController *staticVC = [[StaticViewController alloc]init];
        staticVC.startTimeStr = timeStr;
        staticVC.userName = self.userName;
        [self.navigationController pushViewController:staticVC animated:YES];
    }
    else
    {
        [AllTools messageViewWithText:@"进店时间8：00-22：00，其他时间无法录入！"];
    }
    


}
-(void)staticBtnClick:(UIButton *)b
{

    ClassificationStatisticsViewController *classVC = [[ClassificationStatisticsViewController alloc]init];
    classVC.type = AllType;
    
    [self.navigationController pushViewController:classVC animated:YES];
}
-(void)daoOutBtnClick:(UIButton *)b
{
    
    
    NSDateFormatter *formatter = [NSDateFormatter dateFormatter];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dd = [formatter stringFromDate:[NSDate date]];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *beforeDate = [formatter dateFromString:[NSString stringWithFormat:@"%@ %@",dd,@"08:00:00"]];
    NSDate *afterDate = [formatter dateFromString:[NSString stringWithFormat:@"%@ %@",dd,@"22:00:00"]];
    
    if ([[NSDate date]isLaterThanDate:beforeDate]&&[[NSDate date] isEarlierThanDate:afterDate]) {
    
        [AllTools messageViewWithText:@"8：00—22：00时段不能导出数据!"];
    }
    else
    {
        
        ExportViewController *exportVC = [[ExportViewController alloc]init];
        [self.navigationController pushViewController:exportVC animated:YES];
    }
    
}
-(void)daoInBtnClick:(UIButton *)b
{
    ImportViewController *importVC = [[ImportViewController alloc]init];
    [self.navigationController pushViewController:importVC animated:YES];
    
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
