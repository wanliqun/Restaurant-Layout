//
//  AppDelegate.h
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/13/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RLRoomsManager;
@class RLCoreDataStack;

@interface RLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (RLAppDelegate *)sharedInstance;

@end

