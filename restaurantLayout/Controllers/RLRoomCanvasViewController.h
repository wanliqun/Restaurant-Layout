//
//  RLRoomCanvasViewController.h
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/15/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLViewControllerBase.h"

@class RoomModel;

@interface RLRoomCanvasViewController : RLViewControllerBase

@property (nonatomic, weak) RoomModel *room;

- (void)save;

@end
