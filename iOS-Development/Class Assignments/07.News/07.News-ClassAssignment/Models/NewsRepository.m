//
//  NewsRepository.m
//  07.News-ClassAssignment
//
//  Created by Student07 on 4/15/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "NewsRepository.h"
#import "Article.h"

@implementation NewsRepository

static NewsRepository *sharedInst = nil;

+ (NewsRepository *)sharedInstance {
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
        self.news = [[NSMutableArray alloc] init];
    }
    return sharedInst;
}

-(void) instantiateData {
    for (int index = 0; index < 10; index++) {
        Article *article = [[Article alloc]
                            initWithTitle:[NSString stringWithFormat:@"Article %d", index]
                            andBody:[NSString stringWithFormat:@"Body %d", index]
                            andImage:[UIImage imageNamed:@"image1.jpg"]
                            isFeatured:NO];
        
        if (index % 2 == 0) {
            article.isFeatured = YES;
        }
        
        [self.news addObject:article];
    }
}

@end
