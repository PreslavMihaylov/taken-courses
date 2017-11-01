//
//  NewTaskViewController.m
//  13.TODO-List
//
//  Created by Student07 on 5/13/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "NewTaskViewController.h"
#import "AppDelegate.h"

@interface NewTaskViewController ()

@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@property (nonatomic) NSManagedObjectContext *context;

@end

@implementation NewTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.context = [appDelegate managedObjectContext];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitButtonTouchUpInside:(id)sender {
    NSEntityDescription *newTask = [NSEntityDescription insertNewObjectForEntityForName:@"Task"
                                                                 inManagedObjectContext:self.context];
    
    [newTask setValue:self.contentTextView.text forKey:@"content"];
    [newTask setValue:NO forKey:@"isDone"];
    [self.context save:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
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
