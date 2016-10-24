//
//  ViewController.m
//  06.Contacts-ClassAssignment
//
//  Created by Student07 on 4/8/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "ViewController.h"
#import "PKMUsersRepository.h"
#import "PKMContact.h"

@interface ViewController ()

@end

@implementation ViewController
#define CELL_IDENTIFIER @"CellId"

- (void)viewDidLoad {
    [super viewDidLoad];
    [self instantiateUsers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    cell.imageView.image = ((PKMContact *)[[PKMUsersRepository sharedInstance].contacts objectAtIndex:indexPath.row]).image;
    
    cell.textLabel.text = ((PKMContact *)[[PKMUsersRepository sharedInstance].contacts objectAtIndex:indexPath.row]).name;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[PKMUsersRepository sharedInstance].contacts count];
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    [PKMUsersRepository sharedInstance].selectedUserIndex = indexPath.row;
}

-(void) instantiateUsers {
    for (int index = 0; index < 5; index++) {
        PKMContact *contact = [[PKMContact alloc]
                               initWithName:[NSString stringWithFormat:@"Contact %d", index]
                               andPhoneNumber:[NSString stringWithFormat:@"+359 000 00%d", index]
                               andImage:DEFAULT_USER_IMAGE
                               andDetails:[NSString stringWithFormat:@"Description %d", index]];
    
        [[PKMUsersRepository sharedInstance].contacts addObject:contact];
    }
}

@end
