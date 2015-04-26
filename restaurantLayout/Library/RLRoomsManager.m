//
//  RLRoomsManager.m
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/14/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLRoomsManager.h"
#import "RLCoreDataStack.h"
#import "RLConstants.h"
#import "RoomModel.h"
#import "TableModel.h"

@implementation RLRoomsManager

# pragma mark - shared

+ (RLRoomsManager *) sharedInstance {
    
    __strong static RLRoomsManager *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RLRoomsManager alloc] init];
    });
    
    return sharedInstance;
}

# pragma mark - life cycle

- (id)init {
    
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

# pragma mark - factory methods.

- (RoomModel *)createRoomWithName:(NSString *)name length:(NSInteger)length width:(NSInteger)width {
    
    RoomModel *room = [NSEntityDescription insertNewObjectForEntityForName:[RoomModel entityName]
                                                    inManagedObjectContext:_coredataStack.managedObjectContext];
    room.name = name;
    room.length = length;
    room.width = width;
    
    [_coredataStack saveContext];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kRLNotificationTypeRoomCreated
                                                        object:room userInfo:nil];

    return room;
}


- (TableModel *)addTableWithType:(TableType)type tableNumber:(NSInteger)tableNumber tableSeats:(NSInteger)tableSeats
                       tableSize:(CGFloat)tableSize opposingSeats:(BOOL)opposingSeats forRoom:(RoomModel*)room {
    
    TableModel *table = [NSEntityDescription insertNewObjectForEntityForName:[TableModel entityName]
                                                      inManagedObjectContext:_coredataStack.managedObjectContext];
    table.type = type;
    table.number = tableNumber;
    table.seats = tableSeats;
    table.size = tableSize;
    table.opposing = opposingSeats;
    table.room = room;
    
    return table;
}

- (TableModel *)duplicateTable:(TableModel *)table {
    
    return [self addTableWithType:table.type tableNumber:table.number tableSeats:table.seats tableSize:table.size
                    opposingSeats:table.opposing forRoom:table.room];
}

#pragma mark - utils

- (NSArray *)getAllRooms {
    
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:[RoomModel entityName]];
    
    NSError *error = nil;
    NSArray *results = [_coredataStack.managedObjectContext executeFetchRequest:request error:&error];
    
    if (error != nil) {
        
        NSLog(@"Load All Rooms Failed: %@", [error description]);
        return nil;
    }
    
    return results;
}

- (void)registerTable:(TableModel *)table toRoom:(RoomModel *)room {
    
    [room addTablesObject:table];
    table.room = room;
    
    [_coredataStack saveContext];
}

- (void)deregisterTable:(TableModel *)table fromRoom:(RoomModel *)room {
    
    [room removeTablesObject:table];
    
    table.room = nil;
    [_coredataStack.managedObjectContext deleteObject:table];
    
    [_coredataStack saveContext];
}

- (void)deleteRoom:(RoomModel *)room {
    
    NSSet *tables = [room.tables copy];
    for (TableModel *table in tables) {
        
        [room removeTablesObject:table];
        [_coredataStack.managedObjectContext deleteObject:table];
    }
    
    [_coredataStack.managedObjectContext deleteObject:room];

    [_coredataStack saveContext];
}

@end

