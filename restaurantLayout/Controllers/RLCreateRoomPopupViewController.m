//
//  RLCreateRoomPopupViewController.m
//  restaurantLayout
//
//  Created by WAN LIQUN on 4/14/15.
//  Copyright (c) 2015 bindo. All rights reserved.
//

#import "RLCreateRoomPopupViewController.h"
#import "RLRoomsManager.h"
#import "RLConstants.h"

@interface RLCreateRoomPopupViewController ()

@property (weak, nonatomic) IBOutlet UITextField *roomNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *roomLengthTextField;
@property (weak, nonatomic) IBOutlet UITextField *roomWidthTextField;

@end

@implementation RLCreateRoomPopupViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)click:(id)sender {
    
    NSString *error = [self checkInput];
    
    if ([error length] > 0) {
        [[[UIAlertView alloc] initWithTitle:@"Input Error" message:error delegate:nil
                          cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    } else {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        NSString *roomName   = _roomNameTextField.text;
        NSInteger roomLength = [_roomLengthTextField.text integerValue];
        NSInteger roomWidth  = [_roomWidthTextField.text integerValue];
        [[RLRoomsManager sharedInstance] createRoomWithName:roomName length:roomLength width:roomWidth];
    }
}

- (NSString *)checkInput {
    
    NSMutableArray *errors = [NSMutableArray array];
    
    NSString *roomName = _roomNameTextField.text;
    if ([roomName length] <= 0) {
        [errors addObject:@"Name is empty!"];
    }
    
    NSInteger roomLength = [_roomLengthTextField.text integerValue];
    if (roomLength <= 0 || roomLength > 1024) {
        [errors addObject:@"Length must be between 0 to 1024!"];
    }
    
    NSInteger roomWidth = [_roomWidthTextField.text integerValue];
    if (roomWidth <= 0 || roomWidth > 1024) {
        [errors addObject:@"Width must be between 0 to 1024!"];
    }
    
    if ([errors count] > 0) return [errors componentsJoinedByString:@"\n"];
    return nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
