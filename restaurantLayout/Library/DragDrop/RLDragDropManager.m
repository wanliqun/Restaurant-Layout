//
//  RLDragDropManager.m
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/18/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLDragDropManager.h"
#import "RLAppDelegate.h"
#import "RlDragGestureRecognizer.h"
#import "RLDragContext.h"
#import "RLConstants.h"

@interface RLDragDropManager()

@property (nonatomic, retain) NSMutableSet *draggableViews;

@property (nonatomic, retain) RlDragGestureRecognizer *dragGestureRecognizer;

@property (nonatomic, retain) RLDragContext *dragContext;

@property (nonatomic, weak)   UIWindow *mainWindow;
@property (nonatomic, retain) UIView   *screenCopyView;

@end


@implementation RLDragDropManager

+ (RLDragDropManager *)sharedInstance {
    
    static RLDragDropManager *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RLDragDropManager alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - initialization

- (id)init {
    
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

#pragma mark - utils

- (void)registerDraggableView:(UIView *)view {
    [_draggableViews addObject:view];
}

- (void)setup {
    
    _draggableViews = [NSMutableSet set];
    _dragGestureRecognizer = [[RlDragGestureRecognizer alloc] initWithTarget:nil action:nil];
    _dragGestureRecognizer.cancelsTouchesInView = NO;
    
    _mainWindow = [RLAppDelegate sharedInstance].window;
    [_mainWindow addGestureRecognizer:_dragGestureRecognizer];
    
    [self hookupDragGestureHandler];
}

#pragma mark - event handling

- (void)hookupDragGestureHandler {
    
    __block RLDragDropManager *bself = self;
    
    _dragGestureRecognizer.touchBeganHandler = ^BOOL(NSSet *touches, UIEvent *event) {
        
        UITouch *touch = [touches anyObject];
        
        if ([bself.draggableViews containsObject:touch.view]) {
            
            UIView  *draggedView = touch.view;
            CGPoint dragPositionInWindow = [touch locationInView:nil];
            
            bself.dragContext = [[RLDragContext alloc] init];
            bself.dragContext.draggedView = draggedView;
            bself.dragContext.dragState = DragBegan;
            bself.dragContext.dragPositionInWindow = dragPositionInWindow;
            //NSLog(@"%@", [bself.dragContext description]);
    
            [[NSNotificationCenter defaultCenter] postNotificationName:kRLNotificationTypeDragBegan
                                                                object:[bself.dragContext copy]];
            
            bself.screenCopyView = [touch.view snapshotViewAfterScreenUpdates:YES];
            bself.screenCopyView.hidden = YES;
            [bself.mainWindow addSubview:bself.screenCopyView];
        }
        
        return NO;
    };
    
    _dragGestureRecognizer.touchMovedHandler = ^BOOL(NSSet *touches, UIEvent *event) {
        
        UITouch *touch = [touches anyObject];
        
        if (bself.dragContext) {
            
            CGPoint dragPositionInWindow = [touch locationInView:nil];
            
            bself.dragContext.dragState = DragMoved;
            bself.dragContext.dragPositionInWindow = dragPositionInWindow;
            //NSLog(@"%@", [bself.dragContext description]);
            
            bself.screenCopyView.hidden = NO;
            bself.screenCopyView.center = dragPositionInWindow;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kRLNotificationTypeDragMoved
                                                                object:[bself.dragContext copy]];
        }
        
        return NO;
    };
    
    _dragGestureRecognizer.touchEndedHandler = ^BOOL(NSSet *touches, UIEvent *event) {
        
        UITouch *touch = [touches anyObject];
        
        if (bself.dragContext) {
            
            bself.dragContext.dragState = DragEnded;
            bself.dragContext.dragPositionInWindow = [touch locationInView:nil];
            //NSLog(@"%@", [bself.dragContext description]);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kRLNotificationTypeDragEnded
                                                                object:[bself.dragContext copy]];

            
            [bself clearDragContext];
        }
        
        return NO;
    };
    
    _dragGestureRecognizer.touchCancelledHandler = ^BOOL(NSSet *touches, UIEvent *event) {
        
        UITouch *touch = [touches anyObject];
        
        if (bself.dragContext) {
            
            bself.dragContext.dragState = DragCannceled;
            bself.dragContext.dragPositionInWindow = [touch locationInView:nil];
            //NSLog(@"%@", [bself.dragContext description]);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kRLNotificationTypeDragCanceled
                                                                object:[bself.dragContext copy]];
            
            [bself clearDragContext];
        }
        
        return NO;
    };
}

- (void)clearDragContext {
    
    [self.screenCopyView removeFromSuperview];
    self.screenCopyView = nil;
    
    self.dragContext = nil;
}

@end
