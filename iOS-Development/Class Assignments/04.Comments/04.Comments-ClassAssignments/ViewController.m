//
//  ViewController.m
//  04.Comments-ClassAssignments
//
//  Created by Student07 on 4/1/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
#define COMMENT_TEXT_FIELD_X 60
#define COMMENT_TEXT_FIELD_Y 90

// Image dimensions
#define LEFT_IMAGE_INITIAL_X 8
#define LEFT_IMAGE_INITIAL_Y 42
#define LEFT_IMAGE_INITIAL_WIDTH 141
#define LEFT_IMAGE_INITIAL_HEIGHT 276

#define RIGHT_IMAGE_INITIAL_X 168
#define RIGHT_IMAGE_INITIAL_Y 42
#define RIGHT_IMAGE_INITIAL_WIDTH 125
#define RIGHT_IMAGE_INITIAL_HEIGHT 276

// Layouts dimensions
#define LAYOUT1_PICTURES_VIEW_X 10
#define LAYOUT1_PICTURES_VIEW_Y 57
#define LAYOUT1_SCROLL_VIEW_X 22
#define LAYOUT1_SCROLL_VIEW_Y 389

#define LAYOUT2_PICTURES_VIEW_X 10
#define LAYOUT2_PICTURES_VIEW_Y 228
#define LAYOUT2_SCROLL_VIEW_X 22
#define LAYOUT2_SCROLL_VIEW_Y 57

@property (weak, nonatomic) IBOutlet UIView *picturesView;
@property (weak, nonatomic) IBOutlet UITextView *commentTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (weak, nonatomic) IBOutlet UIButton *postButton;
@property (weak, nonatomic) IBOutlet UIScrollView *commentsScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

@property NSString *imageSelected;
@property NSInteger currentYOffset;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.commentTextField.hidden = YES;
    self.postButton.hidden = YES;
    
    self.currentYOffset = 10;
    self.commentsScrollView.contentSize=CGSizeMake(100,100);
    
    
    self.commentTextField.layer.borderColor = [UIColor blackColor].CGColor;
    self.commentTextField.layer.borderWidth = 1.0;
    
    self.commentsScrollView.layer.borderColor = [UIColor blackColor].CGColor;
    self.commentsScrollView.layer.borderWidth = 1.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)jokerCommentButtonTouchDown:(id)sender {
    self.commentTextField.hidden = NO;
    self.postButton.hidden = NO;
    self.imageSelected = @"left";
    
    [self resizeImages];
}

- (IBAction)batmanCommentTouchDown:(id)sender {
    self.commentTextField.hidden = NO;
    self.postButton.hidden = NO;
    self.imageSelected = @"right";
    
    [self resizeImages];
}

- (IBAction)commentPostedTouchDown:(id)sender {
    self.commentTextField.hidden = YES;
    self.postButton.hidden = YES;
    
    UILabel *newCommentLabel =
    [[UILabel alloc] initWithFrame:
                        CGRectMake(10, self.currentYOffset, 250, 30)];
    
    newCommentLabel.layer.borderColor = [UIColor redColor].CGColor;
    newCommentLabel.layer.borderWidth = 1.0;
    
    self.currentYOffset += 40;
    
    if ([self.imageSelected isEqualToString:@"left"]) {
        newCommentLabel.text = [@"Left Image: " stringByAppendingString:self.commentTextField.text];
        
        self.commentTextField.text = @"";
        [self.commentsScrollView addSubview:newCommentLabel];
    } else {
        newCommentLabel.text = [@"Right Image: " stringByAppendingString:self.commentTextField.text];
        
        self.commentTextField.text = @"";
        [self.commentsScrollView addSubview:newCommentLabel];
    }
    
    self.commentsScrollView.contentSize=CGSizeMake(100,self.currentYOffset);
    
    [self resetImages];
}

- (IBAction)segmentedControlValueChanged:(id)sender {
    if ([self.segmentedControl selectedSegmentIndex] == 0) {
        [self.picturesView setFrame:
         CGRectMake(LAYOUT1_PICTURES_VIEW_X,
                    LAYOUT1_PICTURES_VIEW_Y,
                    self.picturesView.bounds.size.width,
                    self.picturesView.bounds.size.height)];
        
        [self.commentsScrollView setFrame:
         CGRectMake(LAYOUT1_SCROLL_VIEW_X,
                    LAYOUT1_SCROLL_VIEW_Y,
                    self.commentsScrollView.bounds.size.width,
                    self.commentsScrollView.bounds.size.height)];
    } else {
        [self.picturesView setFrame:
         CGRectMake(LAYOUT2_PICTURES_VIEW_X,
                    LAYOUT2_PICTURES_VIEW_Y,
                    self.picturesView.bounds.size.width,
                    self.picturesView.bounds.size.height)];
        
        [self.commentsScrollView setFrame:
         CGRectMake(LAYOUT2_SCROLL_VIEW_X,
                    LAYOUT2_SCROLL_VIEW_Y,
                    self.commentsScrollView.bounds.size.width,
                    self.commentsScrollView.bounds.size.height)];
    }
}

-(void) resizeImages {
    CGRect leftImageDimensions =
    CGRectMake(LEFT_IMAGE_INITIAL_X,
               LEFT_IMAGE_INITIAL_Y + LEFT_IMAGE_INITIAL_HEIGHT / 2,
               LEFT_IMAGE_INITIAL_WIDTH,
               LEFT_IMAGE_INITIAL_HEIGHT / 2);
    
    CGRect rightImageDimensions =
    CGRectMake(RIGHT_IMAGE_INITIAL_X,
               RIGHT_IMAGE_INITIAL_Y + RIGHT_IMAGE_INITIAL_HEIGHT / 2,
               RIGHT_IMAGE_INITIAL_WIDTH,
               RIGHT_IMAGE_INITIAL_HEIGHT / 2);
    
    [self.leftImageView setFrame:leftImageDimensions];
    [self.rightImageView setFrame:rightImageDimensions];
}

-(void) resetImages {
    CGRect leftImageDimensions =
    CGRectMake(LEFT_IMAGE_INITIAL_X,
               LEFT_IMAGE_INITIAL_Y,
               LEFT_IMAGE_INITIAL_WIDTH,
               LEFT_IMAGE_INITIAL_HEIGHT);
    
    CGRect rightImageDimensions =
    CGRectMake(RIGHT_IMAGE_INITIAL_X,
               RIGHT_IMAGE_INITIAL_Y,
               RIGHT_IMAGE_INITIAL_WIDTH,
               RIGHT_IMAGE_INITIAL_HEIGHT);
    
    [self.leftImageView setFrame:leftImageDimensions];
    [self.rightImageView setFrame:rightImageDimensions];
}

@end
