//
//  ImportViewController.m
//  DaoGou
//
//  Created by FayuGuo on 15/7/30.
//  Copyright (c) 2015年 company. All rights reserved.
//

#import "ImportViewController.h"

@interface ImportViewController ()
{
    UITextView *textV;

}
@end

@implementation ImportViewController
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
    [btn setTitle:@"入库" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    
}
-(void)btnClick:(UIButton *)b
{
    
    if ([textV.text isEqualToString:@""]||[textV.text length]<=0) {
        
        [AllTools messageViewWithText:@"数据为空，不能导入！"];
    }
    else
    {
        NSArray *marr = [textV.text objectFromJSONString];
        NSLog(@"marr == 1111==1=1=1=1=1=1= ===%@",marr);
        if (marr==nil||[marr count]<=0) {
            [AllTools messageViewWithText:@"数据异常，请检查数据!"];
        }else{
            FMDataBaseHelper *fm = [FMDataBaseHelper shareInstance];
            [fm insertNewDataToTableName:@"" withArray:marr];
            [AllTools messageViewWithText:@"入库成功！"];
            textV.text = @"";
        }
    }
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.fd_prefersNavigationBarHidden = NO;

    self.title = @"导入数据";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createRightBar];
    
    textV = [[UITextView alloc]init];
    //    textV.delegate = self;
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
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    textV.text = pasteboard.string;

    
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
