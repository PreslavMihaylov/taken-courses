//
//  MusicStarsRepository.h
//  08.MusicStars-ClassAssignment
//
//  Created by Student07 on 4/20/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicStar.h"

@interface MusicStarsRepository : NSObject

@property (nonatomic) NSMutableArray *maleStars;
@property (nonatomic) NSMutableArray *femaleStars;
@property (nonatomic) MusicStar *chosenStarToView;

+ (MusicStarsRepository *)sharedInstance;

@end
