//
//  PKMUser.m
//  03.Payment-ClassAssignment
//
//  Created by Student07 on 3/30/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "PKMUser.h"

@implementation PKMUser

-(id)initWithUsername:(NSString *) username andBalance:(CGFloat) balance andId:(NSInteger)profileId {
    self = [self init];
    
    if (self) {
        _username = username;
        _balance = balance;
        _profileId = profileId;
    }
    
    return self;
}

@end
