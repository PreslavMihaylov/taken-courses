//
//  Song.m
//  07.AlbumsOrganiser-HomeworkAssignment
//
//  Created by Student07 on 4/20/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "Song.h"

@implementation Song

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if ( self ) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.artist = [aDecoder decodeObjectForKey:@"artist"];
        
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.artist forKey:@"artist"];
}

@end
