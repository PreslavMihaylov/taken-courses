//
//  PKMCinemaInfoRepository.m
//  05.Cinemas-ClassAssignment
//
//  Created by Student07 on 4/9/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "PKMCinemaInfoRepository.h"

@implementation PKMCinemaInfoRepository

static PKMCinemaInfoRepository *sharedInst = nil;

+ (PKMCinemaInfoRepository *)sharedInstance {
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
