//
//  Article.h
//  07.News-ClassAssignment
//
//  Created by Student07 on 4/15/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Article : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *body;
@property (nonatomic) UIImage *image;
@property (nonatomic) BOOL isFeatured;

-(instancetype) initWithTitle:(NSString *)title
                      andBody:(NSString *)body
                     andImage:(UIImage *)image
                   isFeatured:(BOOL)featured;

@end
