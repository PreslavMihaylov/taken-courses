//
//  Article.m
//  07.News-ClassAssignment
//
//  Created by Student07 on 4/15/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "Article.h"

@implementation Article

-(instancetype) initWithTitle:(NSString *)title
                      andBody:(NSString *)body
                     andImage:(UIImage *)image
                   isFeatured:(BOOL)featured {
    
    self = [super init];
    if (self) {
        self.title = title;
        self.body = body;
        self.image = image;
        self.isFeatured = featured;
    }
    
    return self;
}

@end
