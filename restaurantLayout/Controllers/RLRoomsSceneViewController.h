//
//  RLRoomsViewController.h
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/13/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLViewControllerBase.h"

@class RLScrollPagerView;
@class RLRoomCanvasViewController;

@interface RLRoomsSceneViewController : RLViewControllerBase

@property (weak, nonatomic) IBOutlet RLScrollPagerView *roomScrollPager;

@property (weak, nonatomic) RLRoomCanvasViewController *roomCanvasVC;

@end
