//
//  PKMVacationInfo.h
//  06.Vacations-HomeworkAssignment
//
//  Created by Student07 on 4/14/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKMVacation.h"

@protocol BrokerDelegate <NSObject>

-(void) goOnVacation:(PKMVacation *)vacation;
- (BOOL) isVacation:(PKMVacation *)vacation openForDate:(NSDate*) dateToCheck;
- (void) reviewVacation:(PKMVacation *) vacation;

@end

@interface PKMVacationInfo : NSObject

@property (nonatomic) VacationType chosenType;
@property (nonatomic) PKMVacation *chosenVacation;
@property (nonatomic) NSMutableArray *availableVacations;
@property (nonatomic) NSMutableArray *bookedVacations;
@property (weak, nonatomic) id <BrokerDelegate> delegate;

+ (PKMVacationInfo *)sharedInstance;
-(void) addVacation:(PKMVacation *)vacation;
-(void) removeVacation:(PKMVacation *)vacation;
-(void) bookVacation: (PKMVacation *)vacation;
-(void) inactiveVacation: (PKMVacation *)vacation;
-(PKMVacation *) generateVacation;

@end
