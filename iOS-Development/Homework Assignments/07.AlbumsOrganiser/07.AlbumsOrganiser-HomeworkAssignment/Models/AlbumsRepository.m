//
//  AlbumsRepository.m
//  07.AlbumsOrganiser-HomeworkAssignment
//
//  Created by Student07 on 4/20/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "AlbumsRepository.h"
#import "Album.h"
#import "Song.h"

@implementation AlbumsRepository

static AlbumsRepository *sharedInst = nil;

// Simulating a single instance class - Singleton
+ (AlbumsRepository *)sharedInstance {
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
    } else if (self = [super init]) {
        sharedInst = self;
        sharedInst.albums = [[NSMutableArray alloc] init];
    }
    return sharedInst;
}

// Read the albums data from the file in the directory.
-(void) instantiateData {
    NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *albumsPath = [documentsDirectory stringByAppendingPathComponent:@"albums.plist"];
    
    NSData *albumsData = [[NSData alloc] initWithContentsOfFile:albumsPath];
    
    if (albumsData) {
        self.albums = [NSKeyedUnarchiver unarchiveObjectWithData:albumsData];
    } else {
        self.albums = [[NSMutableArray alloc] init];
    }
}

// Used for generating some mock albums. Not used anymore.
-(id) generateAlbumByIndex:(NSInteger)index {
    Album *album = [[Album alloc] init];
    album.title = [NSString stringWithFormat:@"Title %ld", index];
    album.artist = [NSString stringWithFormat:@"Artist %ld", index];
    
    for (int i = 0; i < 7; i++) {
        Song *song = [[Song alloc] init];
        song.title = [NSString stringWithFormat:@"Song %d", i];
        song.artist = [NSString stringWithFormat:@"Artist %d", i];
        
        [album.songs addObject:song];
    }
    album.cover = [UIImage imageNamed:@"image1.jpg"];
    album.releaseYear = 2000 + index;
    
    return album;
}

@end
