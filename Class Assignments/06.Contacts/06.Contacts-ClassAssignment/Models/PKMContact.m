//
//  PKMContact.m
//  06.Contacts-ClassAssignment
//
//  Created by Student07 on 4/8/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "PKMContact.h"

@implementation PKMContact

-(instancetype) init {
    self = [super init];
    if (self) {
        self.phoneNumbers = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(instancetype) initWithName:(NSString *)name andPhoneNumber:(NSString *)phoneNumber andImage:(UIImage *) image andDetails:(NSString *)details{
    self = [self init];
    if (self) {
        self.name = name;
        [self.phoneNumbers addObject:phoneNumber];
        self.image = image;
        self.details = details;
    }
    
    
    return self;
}

-(void) addPhoneNumber:(NSString *)phoneNumber {
    [self.phoneNumbers addObject:phoneNumber];
}

@end
