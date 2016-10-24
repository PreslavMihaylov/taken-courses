//
//  PKMCinema.h
//  05.Cinemas-ClassAssignment
//
//  Created by Student07 on 4/6/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKMCinema : UIViewController

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *address;
@property (nonatomic) UIImage *image;
@property (nonatomic) NSString *workingTime;
@property (nonatomic) NSMutableArray *movies;

-(instancetype) initWithTitle:(NSString *)title
                   andAddress:(NSString *)address
                     andImage:(UIImage *)image
               andWorkingTime:(NSString *)workingTime
                    andMovies:(NSMutableArray *)movies;

@end
