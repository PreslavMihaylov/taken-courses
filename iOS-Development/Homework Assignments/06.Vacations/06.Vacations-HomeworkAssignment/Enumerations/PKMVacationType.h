//
//  PKMVacationType.h
//  06.Vacations-HomeworkAssignment
//
//  Created by Student07 on 4/14/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKMVacationType : NSObject

typedef enum : NSInteger {
    Monastery,
    Villa,
    Hotel
} VacationType;

+ (NSString *) formatVacationType:(VacationType) type;

@end
