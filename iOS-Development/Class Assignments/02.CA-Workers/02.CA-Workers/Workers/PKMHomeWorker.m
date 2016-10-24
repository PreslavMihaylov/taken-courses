//
//  PKMHomeWorker.m
//  02.CA-Workers
//
//  Created by Student07 on 3/25/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "PKMHomeWorker.h"

@implementation PKMHomeWorker

#define COEFFICIENT_OF_PRODUCTIVITY (CGFloat) 0.6;

- (id) init {
    self = [super init];
    
    if (self) {
        self.monthlyHours = 80;
        self.salary *= COEFFICIENT_OF_PRODUCTIVITY;
    }
    
    return self;
}

@end
