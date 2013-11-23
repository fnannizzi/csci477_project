//
//  PublishPollController.m
//  status_prototype
//
//  Created by Francesca Nannizzi on 10/21/13.
//  Copyright (c) 2013 Francesca Nannizzi. All rights reserved.
//



#import "PublishPollController.h"


@implementation PublishPollController



- (void)viewDidLoad
{
    NSLog(@"Loading view");
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(Back)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (IBAction)Back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end