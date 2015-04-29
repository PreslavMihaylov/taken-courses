//
//  Album.h
//  07.AlbumsOrganiser-HomeworkAssignment
//
//  Created by Student07 on 4/20/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Album : NSObject <NSCoding>

@property (nonatomic) UIImage *cover;
@property (nonatomic) NSMutableArray *songs;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *artist;
@property (nonatomic) NSInteger releaseYear;
@property (readonly, nonatomic) NSInteger numberOfSongs;

@end
