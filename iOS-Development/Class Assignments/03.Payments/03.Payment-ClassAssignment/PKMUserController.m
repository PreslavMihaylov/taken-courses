//
//  PKMUserController.m
//  03.Payment-ClassAssignment
//
//  Created by Student07 on 3/30/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "PKMUserController.h"
#import "PKMUser.h"
#include <stdlib.h>

@interface PKMUserController ()
#define USERS_COUNT 10

@property NSMutableArray *users;

@end

@implementation PKMUserController

+ (id)instance {
    static PKMUserController *userController = nil;
    @synchronized(self) {
        if (userController == nil)
            userController = [[self alloc] init];
    }
    return userController;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.users = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < USERS_COUNT; i++) {
            CGFloat startingBalance = 500;
            
            [self.users addObject:
             [[PKMUser alloc]
              initWithUsername:[NSString stringWithFormat:@"User %d", i]
              andBalance:startingBalance
              andId:i]];
        }
    }
    
    return self;
}

-(PKMUser *) getUser {
    return self.users[arc4random_uniform(USERS_COUNT)];
}

-(void) proceedPaymentWithAmount:(NSInteger) amount {
        PKMUser *currentUser = [self getUser];
    
        if (currentUser.balance < amount) {
            [self.delegate
             logPaymentMessageForUser:currentUser
             withExitStatus:NO];
        } else {
            currentUser.balance -= amount;
            
            [self.delegate
             logPaymentMessageForUser:currentUser
             withExitStatus:YES];
        }
}

-(void) lendMoneyToUser:(PKMUser *) user withAmount:(CGFloat) amount {
    user.balance += amount;
    [self.delegate logMoneyLendingMessageForUser:user];
}

@end
