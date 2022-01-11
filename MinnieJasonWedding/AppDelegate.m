//
//  AppDelegate.m
//  MinnieJasonWedding
//
//  Created by Jason Wu on 2016/3/18.
//  Copyright © 2016年 Jason Wu. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [AppsFlyerLib shared].isDebug = true;
    [[AppsFlyerLib shared] setAppsFlyerDevKey:@"6ZnqJDgzoM8wA8FbDEWquM"];
    [[AppsFlyerLib shared] setAppleAppID:@"id1094652396"];
    [AppsFlyerLib shared].delegate = self;
    [[AppsFlyerLib shared] waitForATTUserAuthorizationWithTimeoutInterval:60];
    return YES;
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
    [[AppsFlyerLib shared] startWithCompletionHandler:^(NSDictionary<NSString *,id> *dictionary, NSError *error) {
            if (error) {
                NSLog(@"%@", error);
                return;
            }
            if (dictionary) {
                NSLog(@"%@", dictionary);
                return;
            }
        }];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)onConversionDataFail:(nonnull NSError *)error {
    
}

- (void)onConversionDataSuccess:(nonnull NSDictionary *)conversionInfo {
    
}

@end
