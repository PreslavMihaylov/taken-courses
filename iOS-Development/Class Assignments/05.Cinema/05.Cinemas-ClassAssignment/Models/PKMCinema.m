//
//  PKMCinema.m
//  05.Cinemas-ClassAssignment
//
//  Created by Student07 on 4/6/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "PKMCinema.h"



@implementation PKMCinema

-(instancetype) initWithTitle:(NSString *)title
                   andAddress:(NSString *)address
                       andImage:(UIImage *)image
                 andWorkingTime:(NSString *)workingTime
                      andMovies:(NSMutableArray *)movies {
    self = [super init];
    if (self) {
        self.title = title;
        self.address = address;
        self.image = image;
        self.workingTime = workingTime;
        self.movies = movies;
    }
    
    return self;
}

@end
