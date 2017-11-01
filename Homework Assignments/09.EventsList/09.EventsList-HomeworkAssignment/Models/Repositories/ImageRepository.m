//
//  ImageRepository.m
//  09.EventsList-HomeworkAssignment
//
//  Created by Student07 on 4/27/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "ImageRepository.h"

@interface ImageRepository()

@property (nonatomic) NSMutableArray *images;

@end

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

-(NSUInteger)numberOfImages {
    return [self.images count];
}

-(UIImage *)chosenImage {
    if (!_chosenImage ) {
        return self.images[0];
    }
    
    return _chosenImage;
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
        [self instantiateImages];
    }
    return sharedInst;
}

-(UIImage *)getImageAtIndex:(NSUInteger)index {
    return (UIImage *)self.images[index];
}

-(void) instantiateImages {
    [self.images addObject:[UIImage imageNamed:@"image1.jpg"]];
    [self.images addObject:[UIImage imageNamed:@"image2.jpg"]];
    [self.images addObject:[UIImage imageNamed:@"image3.jpg"]];
    [self.images addObject:[UIImage imageNamed:@"image4.jpg"]];
}

@end
