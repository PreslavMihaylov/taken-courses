//
//  PKMContact.h
//  06.Contacts-ClassAssignment
//
//  Created by Student07 on 4/8/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PKMContact : NSObject

@property (nonatomic) NSMutableArray *phoneNumbers;
@property (nonatomic) NSString *name;
@property (nonatomic) UIImage *image;
@property (nonatomic) NSString *details;

-(void) addPhoneNumber:(NSString *)phoneNumber;
-(instancetype) initWithName:(NSString *)name andPhoneNumber:(NSString *)phoneNumber andImage:(UIImage *) image andDetails:(NSString *)details;

@end
