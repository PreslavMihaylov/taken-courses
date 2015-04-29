//
//  PKMUsersRepository.h
//  06.Contacts-ClassAssignment
//
//  Created by Student07 on 4/8/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKMUsersRepository : NSObject
#define DEFAULT_USER_IMAGE [UIImage imageNamed:@"image1.jpg"]

@property (nonatomic) NSMutableArray *contacts;
+ (PKMUsersRepository *)sharedInstance;
@property (nonatomic) NSInteger selectedUserIndex;

@end
