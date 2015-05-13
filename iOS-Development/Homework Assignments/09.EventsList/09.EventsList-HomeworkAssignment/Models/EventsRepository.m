//
//  EventsRepository.m
//  09.EventsList-HomeworkAssignment
//
//  Created by Student07 on 4/24/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "EventsRepository.h"
#import <stdlib.h>
#import "Event.h"

@interface EventsRepository()

@property (nonatomic) NSMutableArray *events;

#define RANDOM_INFO @"Lorem ipsum dolor sit amet, sanctus saperet alienum vix ei, eos ex alii molestiae. Mei at idque minimum dissentiet, vix diam elit et, diam nullam legendos duo id. Tractatos adversarium ne eos, duo te stet equidem accommodare, vel option efficiantur in. Usu at facer aliquid efficiendi. Nonumes convenire persecuti ut pri, has alia iisque ex, ne solum volumus quo."

@end

@implementation EventsRepository

static EventsRepository *sharedInst = nil;

+ (EventsRepository *)sharedInstance {
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
    } else if ( self = [super init] ) {
        sharedInst = self;
        
        sharedInst.events = [[NSMutableArray alloc] init];
        [self instantiateData];
    }
    return sharedInst;
}

-(NSUInteger)numberOfEvents {
    return [self.events count];
}

-(void) addEvent:(Event *)event {
    [self.events addObject:event];
}

-(void) removeEventAtIndex:(NSUInteger)index {
    [self.events removeObjectAtIndex:index];
}

-(Event *) getEventAtIndex:(NSUInteger)index {
    return [self.events objectAtIndex:index];
}

-(void) instantiateData {
    for (int index = 0; index < 20; index++) {
        [self.events addObject:[self generateVacation:index]];
    }
    
    NSSortDescriptor* sortByDate = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    [self.events sortUsingDescriptors:[NSArray arrayWithObject:sortByDate]];
}

- (Event *) generateVacation:(int)index {
    Event *event = [[Event alloc] init];
    event.title = [NSString stringWithFormat:@"Title %d", index];
    event.image = [UIImage imageNamed:@"image1.jpg"];
    event.relatedPerson = [NSString stringWithFormat:@"Person %d", index];
    event.info = RANDOM_INFO;
    event.date = [self generateRandomDate];
    
    return event;
}

-(NSDate *) generateRandomDate {
    int randomTimeInterval = arc4random_uniform(600 * 60 * 24);
    NSDate *now = [NSDate date];
    NSDate *result = [now dateByAddingTimeInterval:randomTimeInterval];
    return result;
}

@end
