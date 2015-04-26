//
//  RLInstallationsSceneViewController.m
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/13/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLInstallationsSceneViewController.h"
#import "RLInstallationContentViewController.h"
#import "RLScrollPagerView.h"

@interface RLInstallationsSceneViewController () <RLScrollPagerDataSource, RLScrollPagerDelegate>

@property (weak, nonatomic) IBOutlet RLScrollPagerView *pageScrollerView;
@property (weak, nonatomic) RLInstallationContentViewController *contentViewController;

@end


@implementation RLInstallationsSceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // scroll pager
    self.pageScrollerView.dataSource = self;
    self.pageScrollerView.delegate = self;
    
    self.pageScrollerView.tabWidth = 112;
    self.pageScrollerView.tabHeight = 78;
    
    [self.pageScrollerView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"rl_ic_embed"]) {
        self.contentViewController = segue.destinationViewController;
    }
}

#pragma mark - RLScrollPagerDataSource

- (NSUInteger)numberOfTabsForScrollPager:(RLScrollPagerView *)scrollPager {
    return 3;
}

- (UIView *)scrollPager:(RLScrollPagerView *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    NSArray *options = @[@"tables", @"bar", @"divisions"];
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.text = options[index];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    
    if (index > 0) {
        label.textColor = [UIColor lightGrayColor];
    }
    
    return label;
}

#pragma mark - RLScrollPagerDelegate

// delegate object must implement this method if wants to be informed when a tab changes
- (void)scrollPager:(RLScrollPagerView *)viewPager didChangeTabToIndex:(NSUInteger)index {
    
    [self.contentViewController swapContentToChildViewControllerWithIndex:index];
}

@end
