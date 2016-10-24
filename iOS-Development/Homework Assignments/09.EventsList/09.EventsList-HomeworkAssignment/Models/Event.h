//
//  Event.h
//  09.EventsList-HomeworkAssignment
//
//  Created by Student07 on 4/24/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Event : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *info;
@property (nonatomic) NSString *relatedPerson;
@property (nonatomic) UIImage *image;
@property (nonatomic) NSDate *date;

@end
