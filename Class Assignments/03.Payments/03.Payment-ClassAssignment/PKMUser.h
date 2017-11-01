//
//  PKMUser.h
//  03.Payment-ClassAssignment
//
//  Created by Student07 on 3/30/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PKMUser : NSObject

@property NSString *username;
@property NSInteger profileId;
@property CGFloat balance;

-(id)initWithUsername:(NSString *) username andBalance:(CGFloat) balance andId:(NSInteger) profileId;

@end
