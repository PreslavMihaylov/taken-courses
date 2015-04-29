//
//  PKMWorker.m
//  02.CA-Workers
//
//  Created by Student07 on 3/25/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "PKMWorker.h"

@implementation PKMWorker

- (id) init {
    self = [super init];
    
    if (self) {
        self.salary = 1000;
        self.monthlyHours = 160;
    }
    
    return self;
}

// - (id) initWithSalary: (CGFloat) salary andMonthlyHours: (NSInteger) monthlyHours {
//    self = self.init;
//
//    self.salary = salary;
//    self.monthlyHours = monthlyHours;
//
//    return self;
//}

@end
