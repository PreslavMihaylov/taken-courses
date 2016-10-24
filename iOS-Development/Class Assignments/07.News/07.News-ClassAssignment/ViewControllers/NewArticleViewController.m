//
//  NewArticleViewController.m
//  07.News-ClassAssignment
//
//  Created by Student07 on 4/17/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "NewArticleViewController.h"
#import "Article.h"
#import "NewsRepository.h"

@interface NewArticleViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UISwitch *isFeaturedSwitch;
@property (weak, nonatomic) IBOutlet UIScrollView *viewScrollView;


#define SCROLL_VIEW_HEIGHT 550
#define SCROLL_VIEW_WIDTH 280
@end

@implementation NewArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.contentTextView.layer.borderWidth = 1.0;
    [self.viewScrollView
     setContentSize:
     CGSizeMake(SCROLL_VIEW_WIDTH, SCROLL_VIEW_HEIGHT)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitButtonTouchDown:(id)sender {
    NSString *title = self.titleTextField.text;
    NSString *content = self.contentTextView.text;
    BOOL isFeatured = self.isFeaturedSwitch.isEnabled;
    
    Article *article =
    [[Article alloc]
        initWithTitle:title
        andBody:content
        andImage:[UIImage imageNamed:@"image1.jpg"]
        isFeatured:isFeatured];
    
    [[NewsRepository sharedInstance].news addObject:article];
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

@end
