//
//  PKMVacation.m
//  06.Vacations-HomeworkAssignment
//
//  Created by Student07 on 4/14/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "PKMVacation.h"

@implementation PKMVacation


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if ( self ) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.type = [aDecoder decodeIntegerForKey:@"type"];
        self.info = [aDecoder decodeObjectForKey:@"info"];
        self.location = [aDecoder decodeObjectForKey:@"location"];
        self.openDays = [aDecoder decodeObjectForKey:@"openDays"];
        self.price = [aDecoder decodeIntegerForKey:@"price"];
        self.reviewCount = [aDecoder decodeIntegerForKey:@"reviewCount"];
        self.image = [aDecoder decodeObjectForKey:@"image"];
        
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.type forKey:@"type"];
    [aCoder encodeObject:self.info forKey:@"info"];
    [aCoder encodeObject:self.location forKey:@"location"];
    [aCoder encodeObject:self.openDays forKey:@"openDays"];
    [aCoder encodeInteger:self.price forKey:@"price"];
    [aCoder encodeInteger:self.reviewCount forKey:@"reviewCount"];
    [aCoder encodeObject:self.image forKey:@"image"];
}

@end
