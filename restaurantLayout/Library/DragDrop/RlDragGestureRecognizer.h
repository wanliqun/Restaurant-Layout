//
//  RlDragGestureRecognizer.h
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/18/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef BOOL(^DragGestureHandler)(NSSet *touches, UIEvent *event);


@interface RlDragGestureRecognizer : UIPanGestureRecognizer

@property (nonatomic, copy) DragGestureHandler touchBeganHandler;

@property (nonatomic, copy) DragGestureHandler touchMovedHandler;

@property (nonatomic, copy) DragGestureHandler touchEndedHandler;

@property (nonatomic, copy) DragGestureHandler touchCancelledHandler;

@end
