//
//  RLDragContext.h
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/18/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DragState) {
    DragBegan, DragMoved, DragEnded, DragCannceled,
};

@interface RLDragContext : NSObject<NSCopying>

@property (nonatomic, weak) UIView *draggedView;

@property (nonatomic, assign) CGPoint   dragPositionInWindow;
@property (nonatomic, assign) DragState dragState;

@end
