//
//  AppDelegate.m
//  iOS_unit_challenge
//
//  Created by 小野 元春 on 2015/05/22.
//  Copyright (c) 2015年 winvelab. All rights reserved.
//

#import "AppDelegate.h"
#import "TopViewController.h"
#import "UIColor+Hex.h"
@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:[[TopViewController alloc]init]];
    self.window.rootViewController = navController;
    self.window.backgroundColor = [UIColor colorWithHex:@"22508B"];
    [self.window makeKeyAndVisible];
    
    [self loadQuizdataJson];

    _userAnswered = [@[] mutableCopy];

    for(int i = 0; i < (int)[_quizData count]; i++) {
        [_userAnswered addObject:@2];
    }
    
    return YES;
}


-(void)loadQuizdataJson{
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:@"quizdata" ofType:@"json"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:jsonFilePath])
    {
        return;
    }
    
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonFilePath];
    
    NSError *error;
    _quizData = [[NSJSONSerialization JSONObjectWithData:jsonData
                                                options:NSJSONReadingAllowFragments
                                                  error:&error] mutableCopy];
}


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

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
