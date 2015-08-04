//
//  StaticViewController.m
//  DaoGou
//
//  Created by FayuGuo on 15/7/21.
//  Copyright (c) 2015年 company. All rights reserved.
//
#define  M_COLOR [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1]
#import "StaticViewController.h"
#define  T_COLOR [UIColor colorWithRed:81/255.0 green:79/255.0 blue:79/255.0 alpha:1]

@interface StaticViewController ()<UIActionSheetDelegate,UITextViewDelegate,UITextFieldDelegate>
{
//    UITableView *myTableView;
    NSMutableArray *dataArray;
    
    UIView *nameView;
    UILabel *nameLabel;
    UITextField *nameTf;
    
    UIView *shopView;
    UILabel *shopLabel;
    UITextView *shopTextView;
    
    UIButton *consumer;
    UIButton *experience;
    UIButton *member;
    UIButton *costAmount;
    UIView *noteView;
    
    UILabel *consumerLabel;
    UILabel *experienceLabel;
    UILabel *memberLabel;
    UILabel *costAmountLabel;
    UILabel *noteLabel;
    UITextView *noteTextView;
    
    UIActionSheet *actionSheet;
    
    UIButton *outShopBtn;
    
    UIView *backView;
    
    float y_offset;
    
    NSString *nameStr;
    NSString *customerTypeStr;
    NSString *experienceTypeStr;
    NSString *memberTypeStr;
    NSString *costAmountTypeStr;
    NSString *buySomeTypeStr;
    NSString *noteTypeStr;
    

}
@end

@implementation StaticViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    self.navigationController.navigationBarHidden = NO;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = YES;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.fd_prefersNavigationBarHidden = NO;
    self.fd_interactivePopDisabled = YES;

    self.title = @"导购信息采集";
    self.view.backgroundColor = [UIColor whiteColor];
    y_offset = 0;
    nameStr = @"";
    customerTypeStr = @"";
    experienceTypeStr = @"";
    memberTypeStr = @"";
    costAmountTypeStr = @"";
    buySomeTypeStr = @"";
    noteTypeStr = @"";

    
    [self.navigationController.navigationItem setHidesBackButton:YES];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
    
    backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];//[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    [self.view addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(64);
        make.bottom.mas_equalTo(self.view).offset(-50);
    }];
    
//    return;
    nameView = [[UIView alloc]init];
    nameView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];    [backView addSubview:nameView];
    
    nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"客户姓名";
    nameLabel.textColor = T_COLOR;
    [nameView addSubview:nameLabel];
    nameTf = [[UITextField alloc]init];
    nameTf.returnKeyType = UIReturnKeyDone;
    nameTf.delegate = self;
    nameTf.borderStyle = UITextBorderStyleRoundedRect;
    [nameView addSubview:nameTf];
    
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.mas_equalTo(backView);
//        make.left.mas_equalTo(backView);
//        make.right.mas_equalTo(backView);
        make.height.equalTo(@50);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.mas_equalTo(nameView).offset(10);
        make.bottom.mas_equalTo(nameView.mas_bottom).offset(-10);
        make.width.equalTo(@70);
    }];
    
    [nameTf mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(nameLabel.mas_right).offset(10);
        make.top.mas_equalTo(nameView).offset(10);
        make.bottom.mas_equalTo(nameView.mas_bottom).offset(-10);
        make.right.mas_equalTo(nameView).offset(-10);
    }];
    
    
//    return;
    consumer = [UIButton buttonWithType:UIButtonTypeCustom];
    [consumer setTitle:@"请选择" forState:UIControlStateNormal];
    [consumer setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [consumer addTarget:self action:@selector(consumerClick) forControlEvents:UIControlEventTouchUpInside];
    consumer.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
//    [consumer setBackgroundColor:[UIColor yellowColor]];
    [consumer setBackgroundColor:M_COLOR];
    [backView addSubview:consumer];
    
    experience = [UIButton buttonWithType:UIButtonTypeCustom];
    [experience setTitle:@"请选择" forState:UIControlStateNormal];
    [experience setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [experience addTarget:self action:@selector(experienceClick) forControlEvents:UIControlEventTouchUpInside];
    experience.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
    [experience setBackgroundColor:M_COLOR];
    [backView addSubview:experience];
    
    member = [UIButton buttonWithType:UIButtonTypeCustom];
    [member setTitle:@"请选择" forState:UIControlStateNormal];
    [member setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [member addTarget:self action:@selector(memberClick) forControlEvents:UIControlEventTouchUpInside];
    member.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
    [member setBackgroundColor:M_COLOR];
    [backView addSubview:member];
    
    costAmount = [UIButton buttonWithType:UIButtonTypeCustom];
    [costAmount setTitle:@"请选择" forState:UIControlStateNormal];
    costAmount.titleEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
    [costAmount setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [costAmount addTarget:self action:@selector(costAmountClick) forControlEvents:UIControlEventTouchUpInside];
    [costAmount setBackgroundColor:M_COLOR];
    [backView addSubview:costAmount];
    
    noteView = [[UIView alloc]init];
    noteView.backgroundColor = M_COLOR;//[UIColor purpleColor];
    [self.view addSubview:noteView];
    
    shopView =  [[UIView alloc]init];
    shopView.backgroundColor = M_COLOR;//[UIColor cyanColor];
    [backView addSubview:shopView];
    
    shopLabel = [[UILabel alloc]init];
    shopLabel.text = @"购买商品";
    shopLabel.textColor = T_COLOR;
    [shopView addSubview:shopLabel];
    
    shopTextView = [[UITextView alloc]init];
    shopTextView.delegate = self;
    shopTextView.returnKeyType = UIReturnKeyDone;
    shopTextView.layer.cornerRadius = 4.0f;
    shopTextView.layer.masksToBounds = YES;
    
    [shopView addSubview:shopTextView];
    
    [consumer mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(nameView.mas_bottom).offset(1);
        make.width.equalTo(backView);
        make.height.equalTo(@50);
    }];
    [experience mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.top.equalTo(consumer.mas_bottom).offset(1);
        make.width.equalTo(consumer);
        make.height.equalTo(consumer);
    }];
    [member mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(experience.mas_bottom).offset(1);
        make.width.equalTo(consumer);
        make.height.equalTo(consumer);
    }];
    
    [costAmount mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(member.mas_bottom).offset(1);
        make.width.equalTo(consumer);
        make.height.equalTo(consumer);
    }];

    [shopView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(costAmount.mas_bottom).offset(1);
        make.width.equalTo(consumer);
        make.height.equalTo(@100);
    }];
    
    [noteView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(shopView.mas_bottom).offset(1);
        make.width.equalTo(consumer);
        make.height.equalTo(@100);
    }];
    
    consumerLabel = [[UILabel alloc]init];
    consumerLabel.text = @"客户类型";
    consumerLabel.textColor = T_COLOR;//[UIColor greenColor];
    [consumer addSubview:consumerLabel];
    
    experienceLabel = [[UILabel alloc]init];
    experienceLabel.text = @"皮肤类型";
    experienceLabel.textColor = T_COLOR;//[UIColor orangeColor];
    [experience addSubview:experienceLabel];
    
    memberLabel = [[UILabel alloc]init];
    memberLabel.text = @"会员类型";
    memberLabel.textColor = T_COLOR;[UIColor greenColor];
    [member addSubview:memberLabel];
    
    costAmountLabel = [[UILabel alloc]init];
    costAmountLabel.text = @"消费区间";
    costAmountLabel.textColor = T_COLOR;//[UIColor greenColor];
    [costAmount addSubview:costAmountLabel];
    
    
    noteLabel = [[UILabel alloc]init];
    noteLabel.text = @"备注";
    noteLabel.textColor = T_COLOR;//[UIColor greenColor];
//    noteLabel.backgroundColor = [UIColor blackColor];
    [noteView addSubview:noteLabel];
    
    
    noteTextView = [[UITextView alloc]init];
    noteTextView.delegate = self;
    noteTextView.returnKeyType = UIReturnKeyDone;
    noteTextView.backgroundColor = [UIColor whiteColor];
    noteTextView.layer.cornerRadius = 4.0f;
    noteTextView.layer.masksToBounds = YES;
    [noteView addSubview:noteTextView];
    
    
    [consumerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.mas_equalTo(consumer).offset(10);
        make.bottom.mas_equalTo(consumer.mas_bottom).offset(-10);
        make.width.equalTo(@70);
    }];
    [experienceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.mas_equalTo(experience).offset(10);
        make.bottom.mas_equalTo(experience.mas_bottom).offset(-10);
        make.width.equalTo(@70);
    }];
    [memberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.mas_equalTo(member).offset(10);
        make.bottom.mas_equalTo(member.mas_bottom).offset(-10);
        make.width.equalTo(@70);
    }];
    
    [costAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.mas_equalTo(costAmount).offset(10);
        make.bottom.mas_equalTo(costAmount.mas_bottom).offset(-10);
        make.width.equalTo(@70);
    }];
    
    [shopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.mas_equalTo(shopView).offset(10);
        make.height.mas_equalTo(costAmountLabel.mas_height);
        make.width.equalTo(@70);
    }];
    
    [shopTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(shopLabel.mas_right).offset(10);
        make.top.mas_equalTo(shopView).offset(10);
        make.bottom.right.mas_equalTo(shopView).offset(-10);
        
    }];
    [noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.mas_equalTo(noteView).offset(10);
        make.height.equalTo(costAmountLabel.mas_height);
        make.width.equalTo(@70);
        
    }];
    [noteTextView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(noteLabel.mas_right).offset(10);
        make.top.mas_equalTo(noteView).offset(10);
        make.bottom.right.mas_equalTo(noteView).offset(-10);
        
    }];
    
    outShopBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [outShopBtn setTitle:@"离店" forState:UIControlStateNormal];
    [outShopBtn setBackgroundColor:[UIColor greenColor]];
    [outShopBtn addTarget:self action:@selector(outShopBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:outShopBtn];
    [outShopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.bottom.right.mas_equalTo(self.view);
        make.height.equalTo(@50);
    }];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];

}
-(void)keyboardShow:(NSNotification *)nf
{
    NSDictionary *userInfo = [nf userInfo]; // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    CGFloat keyboardTop = keyboardRect.origin.y;
//    CGRect newTextViewFrame = self.view.bounds;
    
    if ([shopTextView isFirstResponder]) {
        
        CGRect fr = [shopTextView convertRect:shopTextView.bounds toView:self.view];
        if(CGRectGetMaxY(fr)>=keyboardTop){
        
//            偏移
            y_offset = CGRectGetMaxY(fr) - keyboardTop;
            
        }
        else
        {
            y_offset = 0;
        }
        
    }
    else if ([noteTextView isFirstResponder]){
    
        CGRect fr = [noteTextView convertRect:noteTextView.bounds toView:self.view];
        if(CGRectGetMaxY(fr)>=keyboardTop){
            
            //            偏移
            y_offset = CGRectGetMaxY(fr) - keyboardTop;

        }
        else
        {
            y_offset = 0;

        }
        
    }    

//    newTextViewFrame.size.height = keyboardTop - self.view.bounds.origin.y; // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration]; // Animate the resize of the text view's frame in sync with the keyboard's appearance.
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:animationDuration];
//    textView.frame = newTextViewFrame;
//    [UIView commitAnimations];
    
    
    
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
    
}
-(void)keyboardHide:(NSNotification *)nf
{
    y_offset = 0;
    NSValue *animationDurationValue = [nf.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

//+ (BOOL)requiresConstraintBasedLayout
//{
//    return YES;
//}
-(void)updateViewConstraints
{
 
    [backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-50);
        if ([shopTextView isFirstResponder]||[noteTextView isFirstResponder]) {
            make.top.mas_equalTo(self.view).offset(64-y_offset);
        }
        else
        {
            make.top.mas_equalTo(self.view).offset(64);
        }
        
    }];
    
  
    
    
    [super updateViewConstraints];
    

}
-(void)aaa
{
    [nameTf resignFirstResponder];
    [noteTextView resignFirstResponder];
    [shopTextView resignFirstResponder];

}
-(void)consumerClick
{
    [self aaa];
    
    actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"请选择客户类型"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"高端用户", @"普通用户",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    actionSheet.tag = 101;
    
    [actionSheet showInView:self.view];
}
-(void)experienceClick
{
    [self aaa];
    
    actionSheet = [[UIActionSheet alloc]
                   initWithTitle:@"请选择皮肤类型"
                   delegate:self
                   cancelButtonTitle:@"取消"
                   destructiveButtonTitle:nil
                   otherButtonTitles:@"油性皮肤", @"干性皮肤",@"中性皮肤",@"混合性皮肤",@"敏感皮肤",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    actionSheet.tag = 102;
    [actionSheet showInView:self.view];
}
-(void)memberClick
{
    [self aaa];
    actionSheet = [[UIActionSheet alloc]
                   initWithTitle:@"请选择会员类型"
                   delegate:self
                   cancelButtonTitle:@"取消"
                   destructiveButtonTitle:nil
                   otherButtonTitles:@"VIP", @"首次体验",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    actionSheet.tag = 103;

    [actionSheet showInView:self.view];
}
-(void)costAmountClick
{
    [self aaa];
    actionSheet = [[UIActionSheet alloc]
                   initWithTitle:@"请选择消费范围"
                   delegate:self
                   cancelButtonTitle:@"取消"
                   destructiveButtonTitle:nil
                   otherButtonTitles:@"0-200", @"200-500",@"500-800",@"800-1200",@"1200以上",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    actionSheet.tag = 104;

    [actionSheet showInView:self.view];
}
-(void)outShopBtnClick
{
    
    NSDateFormatter *fm = [NSDateFormatter dateFormatter];
    [fm setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *endTimeStr = [fm stringFromDate:[NSDate date]];
    
    [fm setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [fm stringFromDate:[NSDate date]];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.userName forKey:@"dgName"];
    [dict setObject:self.startTimeStr forKey:@"goinTime"];
    [dict setObject:endTimeStr forKey:@"gooutTime"];
    [dict setObject:customerTypeStr forKey:@"customerType"];
    [dict setObject:experienceTypeStr forKey:@"experienceType"];
    [dict setObject:memberTypeStr forKey:@"memberType"];
    [dict setObject:costAmountTypeStr forKey:@"costAmount"];
    [dict setObject:noteTypeStr forKey:@"note"];
    [dict setObject:nameStr forKey:@"customerName"];
    [dict setObject:buySomeTypeStr forKey:@"buySomething"];
    [dict setObject:dateStr forKey:@"dateStr"];

    FMDataBaseHelper *fmdb = [FMDataBaseHelper shareInstance];
    BOOL ret = [fmdb insertNewDataToTableName:nil withData:dict];
    if (ret) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"提示" message:@"数据入库失败，请联系工作人员" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
        [al show];
    }
    
    
}
#pragma mark UIActionSheetDelegate

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(UIActionSheet *)actionSheet1 clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (actionSheet1.tag - 101) {
        case 0:
        {
            if (buttonIndex == 2) {
                [consumer setTitle:@"请选择" forState:UIControlStateNormal];
                
                customerTypeStr = @"";
//                experienceTypeStr = @"";
//                memberTypeStr = @"";
//                costAmountTypeStr = @"";

            }
            else if(buttonIndex ==0)
            {
                [consumer setTitle:@"高端用户" forState:UIControlStateNormal];
                customerTypeStr= @"高端用户";
            }
            else if (buttonIndex ==1)
            {
                [consumer setTitle:@"普通用户" forState:UIControlStateNormal];
                customerTypeStr = @"普通用户";
            }

        }
            break;
        case 1:
        {
//            :@"油性皮肤", @"干性皮肤",@"中性皮肤",@"混合性皮肤",@"敏感皮肤
            if (buttonIndex == 0) {
                [experience setTitle:@"油性皮肤" forState:UIControlStateNormal];
//                nameStr = @"";
//                customerTypeStr = @"";
                experienceTypeStr = @"油性皮肤";
//                memberTypeStr = @"";
//                costAmountTypeStr = @"";
//                buySomeTypeStr = @"";
//                noteTypeStr = @"";
            }
            else if (buttonIndex ==1)
            {
                [experience setTitle:@"干性皮肤" forState:UIControlStateNormal];
                experienceTypeStr = @"干性皮肤";
            }
            else if (buttonIndex ==2)
            {
                [experience setTitle:@"中性皮肤" forState:UIControlStateNormal];
                experienceTypeStr = @"中性皮肤";
            }
            else if (buttonIndex ==3)
            {
                [experience setTitle:@"混合性皮肤" forState:UIControlStateNormal];
                experienceTypeStr = @"混合性皮肤";
            }
            else if (buttonIndex ==4)
            {
                [experience setTitle:@"敏感皮肤" forState:UIControlStateNormal];
                experienceTypeStr = @"敏感皮肤";
            }
            else if (buttonIndex ==5)
            {
                [experience setTitle:@"请选择" forState:UIControlStateNormal];
                experienceTypeStr = @"";
            }
        }
            break;
        case 2:
        {
            if (buttonIndex ==0) {
                [member setTitle:@"VIP" forState:UIControlStateNormal];
//                nameStr = @"";
//                customerTypeStr = @"";
//                experienceTypeStr = @"";
                memberTypeStr = @"VIP";
//                costAmountTypeStr = @"";
//                buySomeTypeStr = @"";
//                noteTypeStr = @"";

            }
            else if (buttonIndex ==1)
            {
                [member setTitle:@"首次体验" forState:UIControlStateNormal];

                memberTypeStr = @"首次体验";
            }
            else if(buttonIndex == 2)
            {
                [member setTitle:@"请选择" forState:UIControlStateNormal];
                memberTypeStr = @"";
            }
        }
            break;
        case 3:
        {
            if(buttonIndex ==0)
            {
//                @"0-200", @"200-500",@"500-800",@"800-1200",@"1200以上"
                [costAmount setTitle:@"0-200" forState:UIControlStateNormal];
                costAmountTypeStr = @"0-200";
            }
            else if (buttonIndex == 1)
            {
                [costAmount setTitle:@"200-500" forState:UIControlStateNormal];
                costAmountTypeStr = @"200-500";

            }
            else if(buttonIndex ==2)
            {
                [costAmount setTitle:@"500-800" forState:UIControlStateNormal];
                costAmountTypeStr = @"500-800";

            }
            else if (buttonIndex == 3)
            {
                [costAmount setTitle:@"800-1200" forState:UIControlStateNormal];
                costAmountTypeStr = @"800-1200";

            }
            else if (buttonIndex == 4)
            {
                [costAmount setTitle:@"1200以上" forState:UIControlStateNormal];
                costAmountTypeStr = @"1200以上";
            }
            else if (buttonIndex == 5)
            {
                [costAmount setTitle:@"请选择" forState:UIControlStateNormal];
                costAmountTypeStr = @"";
            }
            
        }
            break;
            
        default:
            break;
    }
    
}

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    
}


#pragma mark UITextViewDelegate


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    NSString *str = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        
        if (textView == noteTextView) {
//            nameStr = @"";
//            customerTypeStr = @"";
//            experienceTypeStr = @"";
//            memberTypeStr = @"";
//            costAmountTypeStr = @"";
//            buySomeTypeStr = @"";
            noteTypeStr = str;
        }
        else if (textView == shopTextView){
        
//            nameStr = @"";
//            customerTypeStr = @"";
//            experienceTypeStr = @"";
//            memberTypeStr = @"";
//            costAmountTypeStr = @"";
            buySomeTypeStr = str;
//            noteTypeStr = @"";
        }
        
        return NO;
    }
    
    return YES;
}


#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    nameStr = textField.text;
//    customerTypeStr = @"";
//    experienceTypeStr = @"";
//    memberTypeStr = @"";
//    costAmountTypeStr = @"";
//    buySomeTypeStr = @"";
//    noteTypeStr = @"";
    [textField resignFirstResponder];
    return YES;
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
