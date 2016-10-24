//
//  PKMUsersRepository.m
//  06.Contacts-ClassAssignment
//
//  Created by Student07 on 4/8/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "PKMUsersRepository.h"

@implementation PKMUsersRepository

static PKMUsersRepository *sharedInst = nil;

+ (PKMUsersRepository *)sharedInstance {
    @synchronized( self ) {
        if ( sharedInst == nil ) {
            /* sharedInst set up in init */
            [[self alloc] init];
        }
    }
    
    return sharedInst;
}
- (id)init {
    if ( sharedInst != nil ) {
        [NSException raise:NSInternalInconsistencyException
                    format:@"[%@ %@] cannot be called; use +[%@ %@] instead",
         NSStringFromClass([self class]),
         NSStringFromSelector(_cmd),
         NSStringFromClass([self class]),
         NSStringFromSelector(@selector(sharedInstance))];
    } else if ( self = [super init] ) {
        sharedInst = self;
        sharedInst.contacts = [[NSMutableArray alloc] init];
    }
    return sharedInst;
}

@end
