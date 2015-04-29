//
//  ViewController.m
//  03.Payment-ClassAssignment
//
//  Created by Student07 on 3/30/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "ViewController.h"
#import "PKMUserController.h"
#import <stdlib.h>

@interface ViewController () <UserControllerDelagate>

#define COMPUTER_PRICE 125
#define HDD_PRICE 70
#define SSD_PRICE 90
#define LENDING_AMOUNT 500
@property PKMUser *currentUser;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PKMUserController *instance = [PKMUserController instance];
    instance.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) logPaymentMessageForUser:(PKMUser *)user withExitStatus:(BOOL) status {
    self.currentUser = user;
    
    if (status) {
        NSLog(@"Payment successful! User: %@, Balance: %.02f",
              self.currentUser.username,
              self.currentUser.balance);
    } else {
        NSLog(@"The user %@ doesn't have enough money on his balance. Current balance: %.02f",
              self.currentUser.username,
              self.currentUser.balance);
    }
}

-(void) logMoneyLendingMessageForUser:(PKMUser *)user {
    NSLog(@"Money lending successful for user %@. New balance: %.02f",
          user.username,
          user.balance);
}

- (IBAction)computerButtonTouchDown:(id)sender {
    PKMUserController *controller = [PKMUserController instance];
    
    [controller proceedPaymentWithAmount:COMPUTER_PRICE];
}

- (IBAction)hddButtonTouchDown:(id)sender {
    PKMUserController *controller = [PKMUserController instance];
    
    [controller proceedPaymentWithAmount:HDD_PRICE];
}

- (IBAction)ssdButtonTouchDown:(id)sender {
    PKMUserController *controller = [PKMUserController instance];
    
    [controller proceedPaymentWithAmount:SSD_PRICE];
}


- (IBAction)lendMoneyButtonTouchDown:(id)sender {
    PKMUserController *controller = [PKMUserController instance];
    
    [controller lendMoneyToUser:self.currentUser withAmount:LENDING_AMOUNT];
}

@end
