//
//  ViewController.h
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/13/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RLViewControllerBase.h"

@class RLRoomsSceneViewController, RLInstallationsSceneViewController;

@interface RLViewController : RLViewControllerBase

@property(nonatomic, weak) RLRoomsSceneViewController         *roomsSceneVC;
@property(nonatomic, weak) RLInstallationsSceneViewController *installationsSceneVC;

@end

