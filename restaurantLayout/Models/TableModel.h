//
//  TableModel.h
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/13/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RoomModel;

@interface TableModel : NSManagedObject

@property (nonatomic) double x;
@property (nonatomic) double y;
@property (nonatomic) int16_t number;
@property (nonatomic) BOOL    opposing;
@property (nonatomic) int16_t seats;
@property (nonatomic) double  size;
@property (nonatomic) int16_t type;
@property (nonatomic, retain) RoomModel *room;

+ (NSString *)entityName;

@end
