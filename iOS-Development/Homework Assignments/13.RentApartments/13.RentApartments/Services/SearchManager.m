//
//  SearchManager.m
//  13.RentApartments
//
//  Created by P. Mihaylov on 5/19/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "SearchManager.h"

@implementation SearchManager

static SearchManager *sharedInst = nil;

+ (SearchManager *)sharedInstance {
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
    }
    return sharedInst;
}

@end
