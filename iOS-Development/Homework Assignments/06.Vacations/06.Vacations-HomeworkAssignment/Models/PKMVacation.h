//
//  PKMVacation.h
//  06.Vacations-HomeworkAssignment
//
//  Created by Student07 on 4/14/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKMVacationType.h"
#import <UIKit/UIKit.h>

@interface PKMVacation : NSObject <NSCoding>

@property (nonatomic) VacationType type;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *info;
@property (nonatomic) NSString *location;
@property (nonatomic) NSMutableArray *openDays;
@property (nonatomic) NSInteger price;
@property (nonatomic) NSInteger reviewCount;
@property (nonatomic) UIImage *image;

@end
