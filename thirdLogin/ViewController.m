//
//  ViewController.m
//  thirdLogin
//
//  Created by mac on 15/12/1.
//  Copyright © 2015年 gmtx. All rights reserved.
//

#import "ViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>
//#import "sdkCall.h"
#import <ShareSDK/ShareSDK.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark - qq登陆
- (IBAction)QQLogin:(UIButton *)sender {

    [ShareSDK getUserInfoWithType:ShareTypeQQSpace authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        NSLog(@"%d",result);
        if (result) {
            NSLog(@"登陆成功 %@",userInfo);
            //打印输出用户uid：
            NSLog(@"uid = %@",[userInfo uid]);
            //打印输出用户昵称：
            NSLog(@"name = %@",[userInfo nickname]);
            //打印输出用户头像地址：
            NSLog(@"icon = %@",[userInfo profileImage]);
            
            //成功登录后，判断该用户的ID是否在自己的数据库中。
            //如果有直接登录，没有就将该用户的ID和相关资料在数据库中创建新用户。
//            [self reloadStateWithType:ShareTypeQQSpace];

            [ShareSDK cancelAuthWithType:ShareTypeQQSpace];
        }else{
            NSLog(@"登陆失败 %ld   %@ %@",error.errorCode,error.errorDescription,userInfo);
        }
    }];
}

#pragma mark - 微信登陆
- (IBAction)weixinLoginAction:(id)sender {
    [ShareSDK getUserInfoWithType:ShareTypeWeixiSession authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        NSLog(@"%d",result);
        if (result) {
            NSLog(@"登陆成功 %@",userInfo);
            //打印输出用户uid：
            NSLog(@"uid = %@",[userInfo uid]);
            //打印输出用户昵称：
            NSLog(@"name = %@",[userInfo nickname]);
            //打印输出用户头像地址：
            NSLog(@"icon = %@",[userInfo profileImage]);
            
            //成功登录后，判断该用户的ID是否在自己的数据库中。
            //如果有直接登录，没有就将该用户的ID和相关资料在数据库中创建新用户。
            //            [self reloadStateWithType:ShareTypeQQSpace];
            
            [ShareSDK cancelAuthWithType:ShareTypeWeixiSession];
        }else{
            NSLog(@"登陆失败 %ld  %@ %@",(long)error.errorCode,error.errorDescription,userInfo);
        }
    }];
}



-(void)reloadStateWithType:(ShareType)type{
    //现实授权信息，包括授权ID、授权有效期等。
    //此处可以在用户进入应用的时候直接调用，如授权信息不为空且不过期可帮用户自动实现登录。
    id<ISSPlatformCredential> credential = [ShareSDK getCredentialWithType:type];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"TEXT_TIPS", @"提示")
                                                        message:[NSString stringWithFormat:
                                                                 @"uid = %@\ntoken = %@\nsecret = %@\n expired = %@\nextInfo = %@",
                                                                 [credential uid],
                                                                 [credential token],
                                                                 [credential secret],
                                                                 [credential expired],
                                                                 [credential extInfo]]
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"TEXT_KNOW", @"知道了")
                                              otherButtonTitles:nil];
    [alertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
