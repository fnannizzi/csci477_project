//
//  GroupDataController.h
//  status_prototype
//
//  Created by Francesca Nannizzi on 10/21/13.
//  Copyright (c) 2013 Francesca Nannizzi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Group;

@interface GroupDataController : NSObject

@property (nonatomic, copy) NSMutableArray *masterGroupsList;

- (NSUInteger)groupsCount;
- (Group *)objectInListAtIndex:(NSUInteger)theIndex;
- (void)addGroupWithGroup:(Group *)group;

@end
