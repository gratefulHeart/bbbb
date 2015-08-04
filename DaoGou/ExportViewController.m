//
//  ExportViewController.m
//  DaoGou
//
//  Created by FayuGuo on 15/7/29.
//  Copyright (c) 2015年 company. All rights reserved.
//

#import "ExportViewController.h"

#import "UMSocialControllerService.h"
#import "UMSocialSnsPlatformManager.h"
@import Charts;

@interface ExportViewController ()<UITextViewDelegate>
{
    UITextView *textV;
//    UILabel *label;
}
@end

@implementation ExportViewController
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
-(void)createRightBar
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setFrame:CGRectMake(0, 0, 60, 40)];
    [btn setTitle:@"分享" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    
}
-(void)btnClick:(UIButton *)b
{
    //分享编辑页面的接口,snsName可以换成你想要的任意平台，例如UMShareToSina,UMShareToWechatTimeline
//    NSString *snsName = UMShareToWechatSession;
    NSString *shareText = textV.text;//@"友盟社会化组件可以让移动应用快速具备社会化分享、登录、评论、喜欢等功能，并提供实时、全面的社会化数据统计分析服务。 http://www.umeng.com/social";
    UIImage *shareImage = [UIImage imageNamed:@"UMS_social_demo"];
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatSession] content:shareText image:shareImage location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity * response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"成功" message:@"分享成功" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
            [alertView show];
        } else if(response.responseCode != UMSResponseCodeCancel) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"失败" message:@"分享失败" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
            [alertView show];
        }
    }];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.fd_prefersNavigationBarHidden = NO;

    self.title = @"数据导出";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createRightBar];
    
    textV = [[UITextView alloc]init];
    textV.delegate = self;
    textV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textV.layer.borderWidth = 1.0f;
    textV.layer.cornerRadius = 4.0f;
    textV.layer.masksToBounds = YES;
    [self.view addSubview:textV];
    [textV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(30);
        make.height.equalTo(@450);
    }];
    
    textV.editable = NO;
    
//    label = [[UILabel alloc]init];
//    label.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    label.layer.borderWidth = 1.0f;
//    label.layer.cornerRadius = 4.0f;
//    label.layer.masksToBounds = YES;
//    label.numberOfLines = 0;
//    [self.view addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.mas_equalTo(10);
//        make.right.mas_equalTo(-10);
//        make.top.mas_equalTo(30);
//        make.height.equalTo(@450);
//    }];
    
    
    FMDataBaseHelper *fm = [FMDataBaseHelper shareInstance];
    NSArray *arr = [fm queryTodayData];//[fm queryDataFromTableName:@"" withParas:nil];
    NSLog(@"arr ==  %@",arr);
    NSString *str = [arr JSONString];
    textV.text = str;
    
    NSArray *marr = [str objectFromJSONString];
    NSLog(@"marr == 1111==1=1=1=1=1=1= ===%@",marr);
    
}
- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
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
