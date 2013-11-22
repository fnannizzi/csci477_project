//
//  DetailViewController.m
//  status_prototype
//
//  Created by Francesca Nannizzi on 10/21/13.
//  Copyright (c) 2013 Francesca Nannizzi. All rights reserved.
//



#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
#define kLatestKivaLoansURL [NSURL URLWithString:@"http://api.kivaws.org/v1/loans/search.json?status=fundraising"] //2

#import "DetailViewController.h"
#import "Group.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setGroup:(Group *)newGroup
{
    if (_group != newGroup) {
        _group = newGroup;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    Group *theGroup = self.group;
    
    static NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
    }
    if (theGroup) {
        self.groupLabel.text = theGroup.name;
        // self.sizeLabel.text = [NSString stringWithFormat:@"@%u", *theGroup.size];
        self.creatorNameLabel.text = theGroup.creatorName;
        self.dateCreatedLabel.text = [formatter stringFromDate:(NSDate *)theGroup.dateCreated];
    }
}

- (void)viewDidLoad
{
    NSLog(@"Loading view");
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: kLatestKivaLoansURL];
        // once the data arrives, call fetchedData and pass data to it
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
    
}

- (void)fetchedData:(NSData*)responseData
{ // parses the JSON data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    NSArray* latestLoans = [json objectForKey:@"loans"];
    NSLog(@"loans: %@", latestLoans);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
