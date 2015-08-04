//
//  AppDelegate.m
//  DaoGou
//
//  Created by FayuGuo on 15/7/16.
//  Copyright (c) 2015年 company. All rights reserved.
//
#define XcodeAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#import "AppDelegate.h"
#import "ViewController.h"
#import "RootVViewController.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "MobClickSocialAnalytics.h"
#import "MobClick.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:UmengAppkey];
    [MobClick setLogEnabled:YES];
    
//    [MobClick startWithAppkey:UmengAppkey reportPolicy:(ReportPolicy) REALTIME channelId:nil];

    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    
    //    //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    
    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取

    [MobClick startWithAppkey:UmengAppkey];
    [MobClick updateOnlineConfig];  //在线参数配置

//    [MobClick checkUpdate];
    
    [MobClick checkUpdate:@"新版本" cancelButtonTitle:@"忽略" otherButtonTitles:@"去更新"];
//    [MobClick checkUpdateWithDelegate:self selector:@selector(updateMethod:)];

    
    ViewController *vc = [[ViewController alloc]init];
    RootVViewController *rootv = [[RootVViewController alloc]init];

    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    if (![def objectForKey:@"userName"]) {
     
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        self.window.rootViewController = nav;

    }
    else
    {
        rootv.userName = [def objectForKey:@"userName"];
        
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:rootv];
        self.window.rootViewController = nav;
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)updateMethod:(NSDictionary *)appInfo {
    NSLog(@"update info %@",appInfo);
}
/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}
/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
//- (void)applicationDidBecomeActive:(UIApplication *)application
//{
//    [UMSocialSnsService  applicationDidBecomeActive];
//}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}
/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [UMSocialSnsService  applicationDidBecomeActive];

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
