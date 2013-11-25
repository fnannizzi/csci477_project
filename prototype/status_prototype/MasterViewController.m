//
//  MasterViewController.m
//  status_prototype
//
//  Created by Francesca Nannizzi on 10/21/13.
//  Copyright (c) 2013 Francesca Nannizzi. All rights reserved.
//

#define pollTestURL [NSURL URLWithString:@"http://www-scf.usc.edu/~nannizzi/polls.json"]

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "GroupDataController.h"
#import "Group.h"

/*@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end*/

@implementation MasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
    self.dataController = [[GroupDataController alloc] init];
    
    NSData *pollsData = [[NSData alloc] initWithContentsOfURL:pollTestURL];
    NSError *error;
    self.polls = [NSJSONSerialization JSONObjectWithData:pollsData options:NSJSONReadingMutableContainers error:&error][@"polls"];
	
    if(error){
        NSLog(@"Error loading JSON: %@", [error localizedDescription]);
    }
    else {
        NSLog(@"JSON data loaded.");
        NSLog(@"%@", self.polls);
    }
    
    Group *group;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    
    for(NSDictionary *poll in self.polls){
        //NSDate *date = [dateFormat dateFromString:poll[@"pollName"]];
        NSDate *date = [NSDate date];
        group = [[Group alloc] initWithName:poll[@"pollName"] creatorName:poll[@"creatorName"] dateCreated:date];
        NSLog(@"Poll created.");
        [self.dataController addGroupWithGroup:group];
        NSLog(@"Poll added.");
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(AddNewPoll)];
 //   self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}*/

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section){
        case 0:
            sectionName = NSLocalizedString(@"Polls I've been invited to:", @"Polls I've been invited to:");
            break;
        case 1:
            sectionName = NSLocalizedString(@"Polls I created:", @"Polls I created:");
            break;
    }
    return sectionName;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger numRows = 0;
    switch (section){
        case 0:
            numRows = [self.dataController groupsCount];
            break;
        case 1:
            numRows = [self.dataController groupsCreatedCount];
            break;
    }
    return numRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"GroupCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    static NSDateFormatter *formatter = nil;
    Group *groupAtIndex;
    
    switch (indexPath.section) {
        case 0:
            if (!formatter) {
                formatter = [[NSDateFormatter alloc] init];
                [formatter setDateStyle:NSDateFormatterMediumStyle];
            }
            
            groupAtIndex = [self.dataController objectInListAtIndex:(indexPath.row)];
            [[cell textLabel] setText:groupAtIndex.name];
            [[cell detailTextLabel] setText:[formatter stringFromDate:(NSDate *)groupAtIndex.dateCreated]];
            break;
            
        case 1:
            if (!formatter) {
                formatter = [[NSDateFormatter alloc] init];
                [formatter setDateStyle:NSDateFormatterMediumStyle];
            }
            
            groupAtIndex = [self.dataController objectInCreatedListAtIndex:(indexPath.row)];
            [[cell textLabel] setText:groupAtIndex.name];
            [[cell detailTextLabel] setText:[formatter stringFromDate:(NSDate *)groupAtIndex.dateCreated]];
            break;
    }
    cell.imageView.image = [UIImage imageNamed:@"placeholder.png"];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    switch (indexPath.section){
        case 0:
            return NO;
        case 1:
            return YES;
    }
    return YES;
}

/*- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSDate *object = _objects[indexPath.row];
        self.detailViewController.detailItem = object;
    }
}*/


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowGroupDetails"]) {
        DetailViewController *detailViewController = [segue destinationViewController];
        
        detailViewController.group = [self.dataController objectInListAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
}

@end
