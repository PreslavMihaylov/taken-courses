//
//  AlbumsRepository.h
//  07.AlbumsOrganiser-HomeworkAssignment
//
//  Created by Student07 on 4/20/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Album.h"

@interface AlbumsRepository : NSObject

@property (nonatomic) NSMutableArray *albums;
@property (nonatomic) UIImage *chosenCoverForNewAlbum;
@property (nonatomic) Album *chosenAlbumForDetails;

+ (AlbumsRepository *)sharedInstance;
-(void) instantiateData;

@end
