//
//  ImageRepository.h
//  09.EventsList-HomeworkAssignment
//
//  Created by Student07 on 4/27/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageRepository : NSObject

@property (nonatomic) NSMutableArray *images;
@property (nonatomic) UIImage *chosenImage;

+ (ImageRepository *)sharedInstance;

@end
