//
//  PKMDepartment.m
//  02.CA-Workers
//
//  Created by Student07 on 3/25/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "PKMDepartment.h"
#import <Foundation/Foundation.h>

@implementation PKMDepartment

-(id) init {
    self = [super init];
    
    if (self) {
        self.workers = [NSMutableArray array];
    }
    
    return self;
}

@end
