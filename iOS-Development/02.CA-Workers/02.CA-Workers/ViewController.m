//
//  ViewController.m
//  02.CA-Workers
//
//  Created by Student07 on 3/25/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "ViewController.h"
#import "PKMWorker.h"
#import "PKMAssistant.h"
#import "PKMHomeWorker.h"
#import "PKMDepartment.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    PKMWorker *worker = [[PKMWorker alloc] init];
    
    NSLog(@"Salary: %f, Monthly Hours: %ld", worker.salary, worker.monthlyHours);
    
    PKMAssistant *assistant = [[PKMAssistant alloc] init];
    
    NSLog(@"Salary: %f, Monthly Hours: %ld", assistant.salary, assistant.monthlyHours);
    
    PKMHomeWorker *homeWorker = [[PKMHomeWorker alloc] init];
    
    NSLog(@"Salary: %f, Monthly Hours: %ld", homeWorker.salary, homeWorker.monthlyHours);
    
    PKMDepartment *department = [[PKMDepartment alloc] init];
    
    [department.workers addObject:worker];
    [department.workers addObject:assistant];
    [department.workers addObject:homeWorker];
    
    NSLog(@"\n");
    NSLog(@"Workers by department:");
    for (PKMWorker *object in department.workers) {
        NSLog(@"Salary: %f, Monthly Hours: %ld", object.salary, object.monthlyHours);
    }
    
    CGFloat averageSalary = [self averageSalary:department.workers];
    
    NSLog(@"Average Salary: %f", averageSalary);
    
    
}

- (CGFloat)averageSalary: (NSMutableArray *) array {
    CGFloat averageSalary = 0;
    
    for (PKMWorker *object in array) {
        averageSalary += object.salary;
    }
    
    averageSalary /= [array count];
    
    return averageSalary;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
