//
//  ContactDetailsViewController.m
//  06.Contacts-ClassAssignment
//
//  Created by Student07 on 4/8/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "ContactDetailsViewController.h"
#import "PKMUsersRepository.h"
#import "PKMContact.h"

@interface ContactDetailsViewController()

@property (weak, nonatomic) IBOutlet UIImageView *contactImageView;
@property (weak, nonatomic) IBOutlet UILabel *contactNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *contactDetailsTextView;
@property (nonatomic) PKMContact *currentUser;


@end

@implementation ContactDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSInteger currentUserIndex = [PKMUsersRepository sharedInstance].selectedUserIndex;
    self.currentUser = ((PKMContact *)[PKMUsersRepository sharedInstance].contacts[currentUserIndex]);
    
    self.contactImageView.image = self.currentUser.image;
    
    self.contactNameLabel.text = self.currentUser.name;
    self.contactDetailsTextView.text = self.currentUser.details;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.currentUser.phoneNumbers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
    }
    
    cell.textLabel.text = [self.currentUser.phoneNumbers objectAtIndex:indexPath.row];
    return cell;
}

@end
