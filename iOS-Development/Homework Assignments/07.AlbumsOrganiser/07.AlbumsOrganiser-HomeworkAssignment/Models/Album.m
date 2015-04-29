//
//  Album.m
//  07.AlbumsOrganiser-HomeworkAssignment
//
//  Created by Student07 on 4/20/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "Album.h"

@interface Album()

@end

@implementation Album

-(id) init {
    self = [super init];
    if (self) {
        self.songs = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if ( self ) {
        self.songs = [[NSMutableArray alloc] init];
        self.cover = [aDecoder decodeObjectForKey:@"cover"];
        self.songs = [aDecoder decodeObjectForKey:@"songs"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.artist = [aDecoder decodeObjectForKey:@"artist"];
        self.releaseYear = [aDecoder decodeIntegerForKey:@"releaseYear"];
        
        if (!self.songs) {
            self.songs = [[NSMutableArray alloc] init];
        }
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.cover forKey:@"cover"];
    [aCoder encodeObject:self.songs forKey:@"songs"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.artist forKey:@"artist"];
    [aCoder encodeInteger:self.releaseYear forKey:@"releaseYear"];
    [aCoder encodeInteger:self.numberOfSongs forKey:@"numberOfSongs"];
}

-(NSInteger) numberOfSongs {
    return [self.songs count];
}
@end
