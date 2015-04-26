//
//  RLInstallationContentViewController.m
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/15/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLInstallationContentViewController.h"

@interface RLInstallationContentViewController()

@property (nonatomic, retain) NSArray *childSegueIdentifiers;
@property (nonatomic, weak)  NSString *currentSegueIdentifier;

@end


@implementation RLInstallationContentViewController

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.childSegueIdentifiers = @[@"rl_it_child", @"rl_ib_child", @"rl_id_child"];
    self.currentSegueIdentifier = self.childSegueIdentifiers[0];
    
    [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}

# pragma mark - navigation 

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    UIViewController *targetVC = segue.destinationViewController;
    
    if (self.childViewControllers.count > 0) {
        [self swapFromViewController:self.childViewControllers[0] toViewController:targetVC];
    } else {
        
        [self addChildViewController:targetVC];
        
        targetVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self.view addSubview:targetVC.view];
        
        [segue.destinationViewController didMoveToParentViewController:self];
    }
}

#pragma mark - utils

- (void)swapFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController
{
    
    toViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    
    [self transitionFromViewController:fromViewController toViewController:toViewController duration:0.5
                               options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
                                   
        [fromViewController removeFromParentViewController];
        [toViewController didMoveToParentViewController:self];
    }];
}

- (void)swapContentToChildViewControllerWithIndex:(NSInteger)index {
    
    self.currentSegueIdentifier = _childSegueIdentifiers[index];
    
    [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}


@end
