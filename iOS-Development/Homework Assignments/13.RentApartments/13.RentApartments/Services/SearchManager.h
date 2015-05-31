//
//  SearchManager.h
//  13.RentApartments
//
//  Created by P. Mihaylov on 5/19/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchManager : NSObject

@property (strong, nonatomic) NSString *typeCriteria;
@property (strong, nonatomic) NSNumber *minimumPriceCriteria;
@property (strong, nonatomic) NSNumber *maximumPriceCriteria;
@property (strong, nonatomic) NSString *locationCriteria;
@property (nonatomic) BOOL hasChanged;

+ (SearchManager *)sharedInstance;

@end
