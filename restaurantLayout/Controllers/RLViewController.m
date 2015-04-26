//
//  ViewController.m
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/13/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLViewController.h"
#import "RLRoomsSceneViewController.h"
#import "RLInstallationsSceneViewController.h"
#import "RLCreateRoomPopupViewController.h"
#import "RLAppDelegate.h"

@interface RLViewController ()

@end

@implementation RLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"rl_rs_embed"]) {
        self.roomsSceneVC = segue.destinationViewController;
    } else if ([segue.identifier isEqualToString:@"rl_is_embed"]) {
        self.installationsSceneVC = segue.destinationViewController;
    }
}

@end
