//
//  MasterViewController.h
//  status_prototype
//
//  Created by Francesca Nannizzi on 10/21/13.
//  Copyright (c) 2013 Francesca Nannizzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;
@class GroupDataController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) GroupDataController *dataController;

@end
