//
//  RLRoomCanvasViewController.m
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/15/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLRoomCanvasViewController.h"
#import "RLRectangularRadioButton.h"
#import "RLCircularRadioButton.h"
#import "RLTableSettings.h"
#import "RLRectangularTableView.h"
#import "RLCircularTableView.h"
#import "RLConstants.h"
#import "RLDragContext.h"
#import "RLRoomsManager.h"
#import "RoomModel.h"
#import "TableModel.h"

@interface RLRoomCanvasViewController()

@property (nonatomic, retain) NSMutableArray *roomTableViews;

@property (nonatomic, retain) RLDragContext *dragContext;

@end

@implementation RLRoomCanvasViewController

#pragma mark - life cycle

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)dealloc {
    
    [self save];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - setter & getter 

- (void)setRoom:(RoomModel *)room {
    
    if (_room != room || room == nil) {
        
        _room = room;
        
        [self loadCanvasForRoom:room];
    }
}

#pragma mark - utils

- (void)loadCanvasForRoom:(RoomModel *)room {
    
    [self selectRoomTableView:nil];
    
    for (UIView *v in _roomTableViews) {
        [v removeFromSuperview];
    }
    
    [_roomTableViews removeAllObjects];
    
    if (room != nil) {
        
        for (TableModel *table in room.tables) {
            
            RLRoomTableViewBase *tableView = [self createRoomTableView:table];
            tableView.position = CGPointMake(table.x, table.y);
        }
    }
}

- (void)save {
    
    if (_room) {
        
        [_room setTables:nil];
        
        for (RLRoomTableViewBase *tableView in _roomTableViews) {
            
            TableModel *table = tableView.tableModel;
            [[RLRoomsManager sharedInstance] registerTable:table toRoom:_room];
        }
    }
}

- (void)setup {
    
    _roomTableViews = [NSMutableArray array];
    
    NSArray *noteNames = @[kRLNotificationTypeDragBegan, kRLNotificationTypeDragMoved,
                           kRLNotificationTypeDragEnded, kRLNotificationTypeDragCanceled];
    
    for (NSString *noteName in noteNames) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDragDrop:)
                                                     name:noteName object:nil];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(duplicateTable:)
                                                 name:kRLNotificationTypeDuplicateTable object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTable:)
                                                 name:kRLNotificationTypeRemoveTable object:nil];
}

#pragma mark - event handling

- (void)handleDragDrop:(NSNotification *)note {
    
    //NSLog(@"%@", [note description]);
    
    RLDragContext *dragContext = note.object;
    
    if (dragContext.dragState == DragEnded) {
        
        if (!_room) {
            [[[UIAlertView alloc] initWithTitle:@"Notice" message:@"Please add a room first!"
                                       delegate:nil cancelButtonTitle:@"OK"
                              otherButtonTitles: nil] show];
            return;
        }
        
        RLRadioButton *radioButton = (RLRadioButton *)dragContext.draggedView;
        CGPoint dragPositionInWindow = dragContext.dragPositionInWindow;
        CGPoint locationInView = [self.view convertPoint:dragPositionInWindow fromView:nil];
        
        if([self.view pointInside:locationInView withEvent:nil]) {
            
            NSLog(@"%@", [[RLTableSettings sharedInstance] description]);
            NSLog(@"Drag %@ inside room canvas at (%@)", [radioButton class], NSStringFromCGPoint(locationInView));
            
            TableType tableType = [RLTableSettings sharedInstance].tableType;
            NSUInteger tableNumber = [RLTableSettings sharedInstance].tableNumber;
            NSUInteger tableSeats  = [RLTableSettings sharedInstance].tableSeats;
            CGFloat tableSize = [RLTableSettings sharedInstance].tableSize;
            BOOL opposingSeats = [RLTableSettings sharedInstance].opposingSeats;
            TableModel *tableModel = [[RLRoomsManager sharedInstance] addTableWithType:tableType tableNumber:tableNumber
                                                                            tableSeats:tableSeats tableSize:tableSize
                                                                         opposingSeats:opposingSeats forRoom:_room];
            
            RLRoomTableViewBase *roomTableView = [self createRoomTableView:tableModel];
            roomTableView.position = locationInView;
            
            [self selectRoomTableView:roomTableView];
        }
    }
}

- (void)duplicateTable:(NSNotification *)note {
    
    RLRoomTableViewBase *tableView = note.object;
    if (tableView) {
        
        RLRoomTableViewBase *copyTableView = [tableView copy];
        [_roomTableViews addObject:copyTableView];
        
        [self.view addSubview:copyTableView];
        copyTableView.position = self.view.center;
        
        [self selectRoomTableView:copyTableView];
    }
}

- (void)removeTable:(NSNotification *)note {
    
    RLRoomTableViewBase *tableView = note.object;
    if (tableView) {
        
        [self selectRoomTableView:nil];
        
        [_roomTableViews removeObject:tableView];
        [tableView removeFromSuperview];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"%@", [event description]);
    
    UITouch *touch = [touches anyObject];
    
    if ([touch.view isKindOfClass:[RLRoomTableViewBase class]]) {
        
        RLRoomTableViewBase *tableView = (RLRoomTableViewBase *)touch.view;
        
        [self selectRoomTableView:tableView];
        
        self.dragContext = [[RLDragContext alloc] init];
        self.dragContext.draggedView = touch.view;
    } else {
        [self selectRoomTableView:nil];
    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", [event description]);
    
    if (self.dragContext) {
        
        UITouch *touch = [touches anyObject];
        
        RLRoomTableViewBase *tableView = (RLRoomTableViewBase *)self.dragContext.draggedView;
        CGPoint dragPositionInCanvas= [touch locationInView:self.view];
        tableView.position = dragPositionInCanvas;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    self.dragContext = nil;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.dragContext = nil;
}

#pragma mark - utils

- (void)selectRoomTableView:(RLRoomTableViewBase *)roomTableView {
    
    if (roomTableView) {
        roomTableView.selected = YES;
    }
    
    for (RLRoomTableViewBase *tableView in _roomTableViews) {
        
        if (tableView != roomTableView) {
             tableView.selected = NO;
        }
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kRLNotificationTypeTableSelected
                                                        object:roomTableView];
}

- (RLRoomTableViewBase *)createRoomTableView:(TableModel *)tableModel {
    
    RLRoomTableViewBase *roomTableView = nil;
    if (tableModel.type == SquareTable) {
        roomTableView = [[RLRectangularTableView alloc] initWithTableModel:tableModel];
    } else {
        roomTableView = [[RLCircularTableView alloc] initWithTableModel:tableModel];
    }
    
    //UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTable:)];
    //[roomTableView addGestureRecognizer:tapGestureRecognizer];
    
    [self.view addSubview:roomTableView];
    [_roomTableViews addObject:roomTableView];
    
    return roomTableView;
}


@end
