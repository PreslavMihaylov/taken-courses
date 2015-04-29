//
//  NewEventViewController.m
//  09.EventsList-HomeworkAssignment
//
//  Created by Student07 on 4/27/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "NewEventViewController.h"
#import "ImageRepository.h"
#import "EventsRepository.h"
#import "Event.h"

@interface NewEventViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *relatedPersonTextField;
@property (weak, nonatomic) IBOutlet UITextView *infoTextView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation NewEventViewController

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.imageView.image = [ImageRepository sharedInstance].chosenImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitButtonTouchDown:(id)sender {
    Event *event = [[Event alloc] init];
    event.title = self.titleTextField.text;
    event.info = self.infoTextView.text;
    event.relatedPerson = self.relatedPersonTextField.text;
    event.image = self.imageView.image;
    event.date = self.datePicker.date;
    
    [[EventsRepository sharedInstance].events addObject:event];
    
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
