//
//  AppDelegate.m
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/10/16.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "AppDelegate.h"
#import "TFTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] init];
    self.window.frame = TFScreeFrame;
    self.window.backgroundColor = TFGlobalBg;
    self.window.rootViewController = [[TFTabBarController alloc] init];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}
@end
