//
//  EventsRepository.h
//  09.EventsList-HomeworkAssignment
//
//  Created by Student07 on 4/24/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"

@interface EventsRepository : NSObject

@property (nonatomic) NSMutableArray *events;
@property (nonatomic) Event* chosenEvent;

+ (EventsRepository *)sharedInstance;

@end
