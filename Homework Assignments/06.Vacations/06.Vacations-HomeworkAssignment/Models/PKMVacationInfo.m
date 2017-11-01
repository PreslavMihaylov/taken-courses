//
//  PKMVacationInfo.m
//  06.Vacations-HomeworkAssignment
//
//  Created by Student07 on 4/14/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "PKMVacationInfo.h"
#import <stdlib.h>

@interface PKMVacationInfo()

@property (nonatomic) NSInteger currentGeneratedVacationCounter;

#define RANDOM_INFO @"Lorem ipsum dolor sit amet, sanctus saperet alienum vix ei, eos ex alii molestiae. Mei at idque minimum dissentiet, vix diam elit et, diam nullam legendos duo id. Tractatos adversarium ne eos, duo te stet equidem accommodare, vel option efficiantur in. Usu at facer aliquid efficiendi. Nonumes convenire persecuti ut pri, has alia iisque ex, ne solum volumus quo."

@end

@implementation PKMVacationInfo

static PKMVacationInfo *sharedInst = nil;

+ (PKMVacationInfo *)sharedInstance {
    @synchronized( self ) {
        if ( sharedInst == nil ) {
            /* sharedInst set up in init */
            [[self alloc] init];
        }
    }
    
    return sharedInst;
}
- (id)init {
    if ( sharedInst != nil ) {
        [NSException raise:NSInternalInconsistencyException
                    format:@"[%@ %@] cannot be called; use +[%@ %@] instead",
         NSStringFromClass([self class]),
         NSStringFromSelector(_cmd),
         NSStringFromClass([self class]),
         NSStringFromSelector(@selector(sharedInstance))];
    } else if ( self = [super init] ) {
        sharedInst = self;
        
        NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *availableVacationsPath = [documentsDirectory stringByAppendingPathComponent:@"availableVacations.plist"];
        
        NSData *availableVacationsData = [[NSData alloc] initWithContentsOfFile:availableVacationsPath];
        
        if (availableVacationsData) {
            self.availableVacations = [NSKeyedUnarchiver unarchiveObjectWithData:availableVacationsData];
            [self.availableVacations addObject:[self generateVacation]];
        } else {
            self.availableVacations = [[NSMutableArray alloc] init];
            for (int index = 0; index < 10; index++) {
                [self.availableVacations addObject:[self generateVacation]];
            }
        }
        
        NSString *bookedVacationsPath = [documentsDirectory stringByAppendingPathComponent:@"bookedVacations.plist"];
        
        NSData *const
         bookedVacationsData = [[NSData alloc] initWithContentsOfFile:bookedVacationsPath];
        
        if (bookedVacationsData) {
            self.bookedVacations = [NSKeyedUnarchiver unarchiveObjectWithData:bookedVacationsData];
        } else {
            self.bookedVacations = [[NSMutableArray alloc] init];
        }
        
        self.currentGeneratedVacationCounter = 0;
    }
    return sharedInst;
}

-(void) addVacation:(PKMVacation *)vacation {
    [self.availableVacations addObject:vacation];
}

-(void) removeVacation:(PKMVacation *)vacation {
    NSInteger index = [self.availableVacations indexOfObject:vacation];
    if (index) {
        [self.availableVacations removeObject:vacation];
    }
}

-(void) bookVacation: (PKMVacation *)vacation {
    NSInteger index = [self.availableVacations indexOfObject:vacation];
    if (index) {
        [self.availableVacations removeObject:vacation];
        [self.bookedVacations addObject:vacation];
    }
}

-(void) inactiveVacation: (PKMVacation *)vacation {
    NSInteger index = [self.bookedVacations indexOfObject:vacation];
    if (index) {
        [self.availableVacations addObject:vacation];
        [self.bookedVacations removeObject:vacation];
    }
}

- (PKMVacation *) generateVacation {
    PKMVacation *vacation = [[PKMVacation alloc] init];
    vacation.name = [NSString stringWithFormat:@"Vacation %d", self.currentGeneratedVacationCounter];
    vacation.type = (VacationType)(arc4random_uniform(50) % 3);
    vacation.price = arc4random_uniform(2000) + 500;
    vacation.location = [NSString stringWithFormat:@"Location %d", self.currentGeneratedVacationCounter];
    vacation.info = RANDOM_INFO;
    
    vacation.reviewCount = arc4random_uniform(50);
    vacation.image = [UIImage imageNamed:@"image1.jpg"];
    vacation.openDays = [[NSMutableArray alloc] init];
    
    [vacation.openDays addObject:[self generateRandomDate]];
    [vacation.openDays addObject:[self generateRandomDate]];
    [vacation.openDays addObject:[self generateRandomDate]];
    
    self.currentGeneratedVacationCounter++;
    return vacation;
}

-(NSDate *) generateRandomDate {
    int randomTimeInterval = arc4random_uniform(600*60*24);
    NSDate *now = [NSDate date];
    NSDate *result = [now dateByAddingTimeInterval:randomTimeInterval];
    return result;
}

@end
