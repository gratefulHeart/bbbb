//
//  ViewController.m
//  DaoGou
//
//  Created by FayuGuo on 15/7/16.
//  Copyright (c) 2015年 company. All rights reserved.
//

#import "ViewController.h"
#import "RootVViewController.h"
@interface ViewController ()<UITextFieldDelegate>
{
    UITextField *stuInfoTF;
    UITextField *bindTF;

    UIButton *goInToBtn;
    
    
    
}
@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.navigationBarHidden = YES;
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_img"]];
    
    UIImageView *imgv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_img"]];
//    UIImageView *imgv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pad_bg.jpg"]];

    [self.view addSubview:imgv];
    [imgv mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(self.view.bounds.size);
    
    }];
    
    stuInfoTF = [[UITextField alloc]init];
    stuInfoTF.returnKeyType = UIReturnKeyGo;
    stuInfoTF.placeholder = @"请输入员工姓名";
    stuInfoTF.delegate = self;
    stuInfoTF.borderStyle = UITextBorderStyleRoundedRect;
    stuInfoTF.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:stuInfoTF];
    
    [stuInfoTF mas_makeConstraints:^(MASConstraintMaker *maker){
        
        maker.size.mas_equalTo(CGSizeMake(300, 50));
        maker.centerX.equalTo(self.view);
        maker.centerY.equalTo(self.view).with.offset(-100);
    }];
    
    
    
    goInToBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [goInToBtn setBackgroundImage:[UIImage imageNamed:@"into_bg"] forState:UIControlStateNormal];
    [goInToBtn setBackgroundImage:[UIImage imageNamed:@"into_bg_dis"] forState:UIControlStateDisabled];
    goInToBtn.enabled = NO;
    [goInToBtn addTarget:self action:@selector(goInToBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goInToBtn];

    [goInToBtn mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.centerX.equalTo(self.view);
        make.top.equalTo(stuInfoTF.mas_bottom).with.offset(50);
        
    }];
    
    
    
    
}
-(void)goInToBtnClick:(UIButton *)b
{
//    RootViewController *rootVC = [[RootViewController alloc]init];
//    [self.navigationController pushViewController:rootVC animated:YES];
    
    
    NSUserDefaults *defaultS = [NSUserDefaults standardUserDefaults];
    [defaultS setObject:stuInfoTF.text forKey:@"userName"];
    [defaultS synchronize];
    
    
    RootVViewController *rootVC = [[RootVViewController alloc]init];
    rootVC.userName = stuInfoTF.text;
    [self.navigationController pushViewController:rootVC animated:YES];

    
}
#pragma mark UITextFieldDelegate
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
//- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
//- (void)textFieldDidEndEditing:(UITextField *)textField;             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
//
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string   // return NO to not change text
{
    NSString *textStr = textField.text;
    textStr = [textStr stringByReplacingCharactersInRange:range withString:string];
    NSLog(@"textStr=====d%@",textStr);
    if ([textStr length]>0) {
        goInToBtn.enabled  = YES;
    }
    else
    {
        goInToBtn.enabled = NO;
    }
    return YES;
}
//
//- (BOOL)textFieldShouldClear:(UITextField *)textField;               // called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField              // called when 'return' key pressed. return NO to ignore.
{
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
