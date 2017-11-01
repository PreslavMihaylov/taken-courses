//
//  NewNotificationViewController.m
//  14.Notifications
//
//  Created by Student07 on 5/18/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "NewNotificationViewController.h"
#import "AppDelegate.h"

@interface NewNotificationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *notificationDatePicker;

@end

@implementation NewNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submitButtonTouchUpInside:(id)sender {
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    notification.fireDate = self.notificationDatePicker.date;
    
    notification.alertBody = self.messageTextField.text;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSEntityDescription *newNotification = [NSEntityDescription insertNewObjectForEntityForName:@"Notification"
                                                                 inManagedObjectContext:context];
    
    [newNotification setValue:self.messageTextField.text forKey:@"alertBody"];
    [newNotification setValue:self.notificationDatePicker.date forKey:@"date"];
    
    [context save:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
