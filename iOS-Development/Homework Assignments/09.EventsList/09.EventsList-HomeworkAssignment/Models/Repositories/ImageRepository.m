//
//  ImageRepository.m
//  09.EventsList-HomeworkAssignment
//
//  Created by Student07 on 4/27/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "ImageRepository.h"

@implementation ImageRepository

static ImageRepository *sharedInst = nil;

+ (ImageRepository *)sharedInstance {
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
        
        self.images = [[NSMutableArray alloc] init];
        self.chosenImage = [UIImage imageNamed:@"image1.jpg"];
        [self instantiateImages];
    }
    return sharedInst;
}

-(void) instantiateImages {
    [self.images addObject:[UIImage imageNamed:@"image1.jpg"]];
    [self.images addObject:[UIImage imageNamed:@"image2.jpg"]];
    [self.images addObject:[UIImage imageNamed:@"image3.jpg"]];
    [self.images addObject:[UIImage imageNamed:@"image4.jpg"]];
}

@end
