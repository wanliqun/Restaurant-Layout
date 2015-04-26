//
//  AppDelegate.m
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/13/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLAppDelegate.h"
#import "RLCoreDataStack.h"
#import "RLRoomsManager.h"

@interface RLAppDelegate ()

@property (nonatomic, retain) RLCoreDataStack *coredataStack;

@end

@implementation RLAppDelegate

+ (RLAppDelegate *)sharedInstance {
    return [UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    [self setup];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self save];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self save];
}

#pragma mark - private

- (void)setup {
    
    // Initialize the core data stack
    _coredataStack = [[RLCoreDataStack alloc] init];
    
    // Initilize the room manager
    [RLRoomsManager sharedInstance].coredataStack = _coredataStack;
}

- (void)save {
    [_coredataStack saveContext];
}

@end
