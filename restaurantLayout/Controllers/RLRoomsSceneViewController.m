//
//  RLRoomsViewController.m
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/13/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLRoomsSceneViewController.h"
#import "RLRoomCanvasViewController.h"
#import "RLScrollPagerView.h"
#import "RLConstants.h"
#import "RoomModel.h"
#import "RLRoomsManager.h"

@interface RLRoomsSceneViewController () <RLScrollPagerDataSource, RLScrollPagerDelegate>

@property (nonatomic, retain) NSMutableArray *rooms;
@property (weak, nonatomic) IBOutlet UIView *roomActionPannel;

@end

@implementation RLRoomsSceneViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // data initialization
    
    NSArray *allRooms = [[RLRoomsManager sharedInstance] getAllRooms];
    
    if ([allRooms count] > 0) {
        _rooms = [NSMutableArray arrayWithArray:allRooms];
    } else {
        _rooms = [NSMutableArray array];
    }
    
    [self refreshActionPanel];
    
    // scroll pager
    self.roomScrollPager.dataSource = self;
    self.roomScrollPager.delegate = self;
    [self.roomScrollPager reloadData];
    
    // notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newRoom:)
                                                 name:kRLNotificationTypeRoomCreated object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - utils

- (void)refreshActionPanel {
    
    _roomActionPannel.hidden = ([_rooms count] > 0) ? NO : YES;
}

- (IBAction)delete:(id)sender {
    
    RoomModel *room = _roomCanvasVC.room;
    _roomCanvasVC.room = nil;
    
    if (room) {
        
        [[RLRoomsManager sharedInstance] deleteRoom:room];
        
        NSInteger activeIndex = [_rooms indexOfObject:room];
        [_rooms removeObject:room];
        
        activeIndex = activeIndex < [_rooms count] ? activeIndex : (activeIndex - 1);
        self.roomScrollPager.startFromSecondTab = activeIndex;
        [self.roomScrollPager reloadData];
        
        if (activeIndex >= 0) {
            _roomCanvasVC.room = _rooms[activeIndex];
        }
        
        [self refreshActionPanel];
    }
}

#pragma mark - notification 

- (void)newRoom:(NSNotification *)note {
    
    if (note.object != nil) {
        
        [_rooms addObject:note.object];
        
        self.roomScrollPager.startFromSecondTab = [_rooms count] - 1;
        [self.roomScrollPager reloadData];
        
        [self refreshActionPanel];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"rl_rc_embed"]) {
        self.roomCanvasVC = segue.destinationViewController;
    }
}

#pragma mark - RLScrollPagerDataSource

- (NSUInteger)numberOfTabsForScrollPager:(RLScrollPagerView *)scrollPager {
    return [self.rooms count];
}

- (UIView *)scrollPager:(RLScrollPagerView *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    RoomModel *room = self.rooms[index];
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:16.0];
    label.text = room.name;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    
    return label;
}

#pragma mark - RLScrollPagerDelegate

// delegate object must implement this method if wants to be informed when a tab changes
- (void)scrollPager:(RLScrollPagerView *)viewPager didChangeTabToIndex:(NSUInteger)index {
    
    [_roomCanvasVC save];
    
    if ([_rooms count] > 0) {
        _roomCanvasVC.room = _rooms[index];
    }
}

@end
