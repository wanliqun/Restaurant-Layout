//
//  RLRoomsManager.h
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/14/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RLTableSettings.h"

@class RLCoreDataStack;
@class RoomModel;
@class TableModel;

@interface RLRoomsManager : NSObject

@property (nonatomic, weak) RLCoreDataStack *coredataStack;

+ (RLRoomsManager *) sharedInstance;

- (NSArray *)getAllRooms;

- (RoomModel *)createRoomWithName:(NSString *)name length:(NSInteger)length width:(NSInteger)width;

- (void)deleteRoom:(RoomModel *)room;

- (TableModel *)addTableWithType:(TableType)type tableNumber:(NSInteger)tableNumber tableSeats:(NSInteger)tableSeats
                       tableSize:(CGFloat)tableSize opposingSeats:(BOOL)opposingSeats forRoom:(RoomModel *)room;

- (TableModel *)duplicateTable:(TableModel *)table;

- (void)registerTable:(TableModel *)table toRoom:(RoomModel *)room;

- (void)deregisterTable:(TableModel *)table fromRoom:(RoomModel *)room;

@end
