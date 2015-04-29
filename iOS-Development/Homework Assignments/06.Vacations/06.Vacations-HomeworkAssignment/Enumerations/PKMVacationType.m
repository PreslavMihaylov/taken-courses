//
//  PKMVacationType.m
//  06.Vacations-HomeworkAssignment
//
//  Created by Student07 on 4/14/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "PKMVacationType.h"

@implementation PKMVacationType

+ (NSString *) formatVacationType:(VacationType) type {
    switch (type) {
        case Monastery:
            return @"Monastery";
        case Villa:
            return @"Villa";
        case Hotel:
            return @"Hotel";
        default:
            [NSException raise:NSGenericException format:@"Unexpected VacationType."];
    }
}

@end
