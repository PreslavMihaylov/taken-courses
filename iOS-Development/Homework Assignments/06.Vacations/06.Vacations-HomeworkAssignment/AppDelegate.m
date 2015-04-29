//
//  AppDelegate.m
//  06.Vacations-HomeworkAssignment
//
//  Created by Student07 on 4/14/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "AppDelegate.h"
#import "PKMVacationInfo.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    for (PKMVacation *vacation in [PKMVacationInfo sharedInstance].availableVacations) {
        vacation.price += (CGFloat)vacation.price * 0.2;
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *availableVacationsPath = [documentsDirectory stringByAppendingPathComponent:@"availableVacations.plist"];
    
    [NSKeyedArchiver archiveRootObject:[PKMVacationInfo sharedInstance].availableVacations toFile:availableVacationsPath];
    
    NSString *bookedVacationsPath = [documentsDirectory stringByAppendingPathComponent:@"bookedVacations.plist"];
    
    [NSKeyedArchiver archiveRootObject:[PKMVacationInfo sharedInstance].bookedVacations toFile:bookedVacationsPath];
}

@end
