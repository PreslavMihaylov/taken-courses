//
//  MusicStarsRepository.m
//  08.MusicStars-ClassAssignment
//
//  Created by Student07 on 4/20/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "MusicStarsRepository.h"
#import "MusicStar.h"

@implementation MusicStarsRepository

static MusicStarsRepository *sharedInst = nil;

+ (MusicStarsRepository *)sharedInstance {
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
        self.maleStars = [[NSMutableArray alloc] init];
        self.femaleStars = [[NSMutableArray alloc] init];
        [self initializeData];
    }
    return sharedInst;
}

-(void)initializeData {
    for (int index = 0; index < 6; index++) {
        MusicStar *star = [[MusicStar alloc] init];
        star.name = [NSString stringWithFormat:@"Male Star %d", index];
        star.image = [UIImage imageNamed:@"image1.jpg"];
        [self.maleStars addObject:star];
    }
    
    for (int index = 0; index < 5; index++) {
        MusicStar *star = [[MusicStar alloc] init];
        star.name = [NSString stringWithFormat:@"Female Star %d", index];
        star.image = [UIImage imageNamed:@"image2.jpg"];
        [self.femaleStars addObject:star];
    }
}

@end
