//
//  Event.m
//  09.EventsList-HomeworkAssignment
//
//  Created by Student07 on 4/24/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "Event.h"

@implementation Event

- (NSComparisonResult)compare:(Event *)secondObject {
    return [self.date compare:secondObject.date];
}

- (NSString *)description {
    return self.date;
}

@end
