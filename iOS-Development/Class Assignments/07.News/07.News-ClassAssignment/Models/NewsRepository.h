//
//  NewsRepository.h
//  07.News-ClassAssignment
//
//  Created by Student07 on 4/15/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsRepository : NSObject

@property (nonatomic) NSMutableArray *news;
+ (NewsRepository *)sharedInstance;
-(void) instantiateData;

@end
