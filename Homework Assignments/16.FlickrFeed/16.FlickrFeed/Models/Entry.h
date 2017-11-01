//
//  Entry.h
//  16.FlickrFeed
//
//  Created by P. Mihaylov on 5/27/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entry : NSManagedObject

@property (nonatomic, retain) NSDate * published;
@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * original;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * identifier;

@end
