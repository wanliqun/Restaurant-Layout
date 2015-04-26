//
//  RLDragContext.m
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/18/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLDragContext.h"

@implementation RLDragContext

- (id)copyWithZone:(NSZone *)zone {
    
    RLDragContext *copy = [RLDragContext allocWithZone:zone];
    copy.draggedView          = self.draggedView;
    copy.dragState            = self.dragState;
    copy.dragPositionInWindow = self.dragPositionInWindow;
    
    return copy;
}

- (NSString *)description {
    
    NSMutableString * description = [NSMutableString stringWithString:@"RLDragContext details: "];
    
    NSString *viewDescription = [NSString stringWithFormat:@"draggedView: %@ ", [_draggedView description]];
    [description appendString:viewDescription];
    
    NSString *positionInWinDescription = [NSString stringWithFormat:@"Position in window: %@ ",
                                          NSStringFromCGPoint(_dragPositionInWindow)];
    [description appendString:positionInWinDescription];
    
    NSString *stateDescription = [NSString stringWithFormat:@"State: %@", [@(_dragState) stringValue]];
    [description appendString:stateDescription];
    
    return description;
}

@end
