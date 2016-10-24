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

@property (nonatomic) Event* chosenEvent;
@property (nonatomic, readonly) NSUInteger numberOfEvents;

-(void) addEvent:(Event *)event;

-(void) removeEventAtIndex:(NSUInteger)index;

-(Event *) getEventAtIndex:(NSUInteger)index;

+ (EventsRepository *)sharedInstance;

@end
