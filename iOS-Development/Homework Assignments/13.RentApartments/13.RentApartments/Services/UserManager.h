//
//  UserManager.h
//  13.RentApartments
//
//  Created by Student07 on 5/16/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Apartment.h"

@interface UserManager : NSObject

@property (strong, nonatomic) User *loggedUser;
@property (strong, nonatomic) Apartment *selectedApartment;

+ (UserManager *)sharedInstance;

@end
