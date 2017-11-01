//
//  PKMUserController.h
//  03.Payment-ClassAssignment
//
//  Created by Student07 on 3/30/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKMUser.h"

@protocol UserControllerDelagate <NSObject>

-(void) logPaymentMessageForUser:(PKMUser *)user withExitStatus:(BOOL) status;

-(void) logMoneyLendingMessageForUser:(PKMUser *)user;

@end

@interface PKMUserController : NSObject

+(id)instance;
-(PKMUser *)getUser;
-(void)proceedPaymentWithAmount:(NSInteger)amount;
-(void)lendMoneyToUser:(PKMUser *)user withAmount:(CGFloat) amount;

@property (weak, nonatomic) id <UserControllerDelagate> delegate;

@end
