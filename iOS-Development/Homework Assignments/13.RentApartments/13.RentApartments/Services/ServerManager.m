//
//  ServerManager.m
//  13.RentApartments
//
//  Created by Student07 on 5/16/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "ServerManager.h"
#import "AppDelegate.h"
#import "Apartment.h"
#import "User.h"

@implementation ServerManager

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

static ServerManager *sharedInst = nil;

+ (ServerManager *)sharedInstance {
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
        
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10.0
                                                          target:sharedInst
                                                        selector:@selector(randomDatabaseManipulation)
                                                        userInfo:nil
                                                         repeats:YES];
    }
    
    return sharedInst;
}

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.mihaylov._3_RentApartments" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"_3_RentApartments" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"_3_RentApartments.sqlite"];
    
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Apartment Validation

- (BOOL)isApartment:(Apartment *)apartment stillPresentInContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Apartment"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF = %@", apartment];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSUInteger count = [context countForFetchRequest:request
                                               error:&error];
    if (!error) {
        return count;
    } else {
        return 0;
    }
}

#pragma mark - Scheduled Function

- (void) randomDatabaseManipulation {
    int chance = arc4random_uniform(3);
    
    NSManagedObjectContext *context = sharedInst.managedObjectContext;
    
    if (chance == 1) {
        // Create object
        
        Apartment *newApartment = [NSEntityDescription insertNewObjectForEntityForName:@"Apartment"
                                                                inManagedObjectContext:context];
        
        User *botUser;
        
        NSEntityDescription *userDescription = [NSEntityDescription entityForName:@"User"
                                                           inManagedObjectContext:context];
        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:userDescription];
        
        // Set example predicate and sort orderings...
        NSPredicate *predicate = [NSPredicate predicateWithFormat:
                                  @"(username = 'botUser')"];
        
        [request setPredicate:predicate];
        
        
        NSError *error;
        NSArray *array = [context executeFetchRequest:request error:&error];
        
        if ([array count] == 0)
        {
            botUser = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                                    inManagedObjectContext:context];
            botUser.username = @"botUser";
        } else {
            botUser = array[0];
        }
        
        newApartment.location = @"Bot location";
        newApartment.publisher = botUser;
        newApartment.price = @100;
        newApartment.details = @"Bot details";
        newApartment.type = @"Single";
        newApartment.image = UIImagePNGRepresentation([UIImage imageNamed:@"apartment.jpg"]);
    } else if (chance == 2) {
        // Delete object
        NSEntityDescription *apartmentDescription = [NSEntityDescription entityForName:@"Apartment"
                                                                inManagedObjectContext:context];
        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:apartmentDescription];
        
        NSError *error;
        NSArray *array = [context executeFetchRequest:request error:&error];
        
        if ([array count] == 0)
        {
            return;
        } else {
            int randomIndex = arc4random_uniform([array count]);
            [context deleteObject:array[randomIndex]];
        }
    }
    
    [context save:nil];
}

@end
