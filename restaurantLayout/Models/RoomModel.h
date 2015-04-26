//
//  RoomModel.h
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/13/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TableModel;

@interface RoomModel : NSManagedObject

@property (nonatomic) int16_t length;
@property (nonatomic, retain) NSString * name;
@property (nonatomic) int16_t width;
@property (nonatomic, retain) NSSet *tables;

+ (NSString *)entityName;

@end

@interface RoomModel (CoreDataGeneratedAccessors)

- (void)addTablesObject:(TableModel *)value;
- (void)removeTablesObject:(TableModel *)value;
- (void)addTables:(NSSet *)values;
- (void)removeTables:(NSSet *)values;

@end
