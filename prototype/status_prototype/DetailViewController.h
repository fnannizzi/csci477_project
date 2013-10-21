//
//  DetailViewController.h
//  status_prototype
//
//  Created by Francesca Nannizzi on 10/21/13.
//  Copyright (c) 2013 Francesca Nannizzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Group;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Group *group;
@property (weak, nonatomic) IBOutlet UILabel *groupLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateCreatedLabel;

@end
