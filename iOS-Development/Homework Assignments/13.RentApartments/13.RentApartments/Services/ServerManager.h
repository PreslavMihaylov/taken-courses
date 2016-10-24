//
//  ServerManager.h
//  13.RentApartments
//
//  Created by Student07 on 5/16/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Apartment.h"

@interface ServerManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (ServerManager *)sharedInstance;
- (BOOL)isApartment:(Apartment *)apartment stillPresentInContext:(NSManagedObjectContext *)context;
- (void)saveContext;

@end
