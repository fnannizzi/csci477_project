//
//  GroupDataController.m
//  status_prototype
//
//  Created by Francesca Nannizzi on 10/21/13.
//  Copyright (c) 2013 Francesca Nannizzi. All rights reserved.
//

#import "GroupDataController.h"
#import "Group.h"

@interface GroupDataController ()
- (void)initializeDefaultDataList;
@end

@implementation GroupDataController

- (void)initializeDefaultDataList {
    NSMutableArray *groupsList = [[NSMutableArray alloc] init];
    self.masterGroupsList = groupsList;
    Group *group;
    NSDate *today = [NSDate date];
    group = [[Group alloc] initWithName:@"Default member poll" creatorName:@"Francesca" dateCreated:today];
    [self addGroupWithGroup:group];
    
    group = [[Group alloc] initWithName:@"Default creator poll" creatorName:@"Francesca" dateCreated:today];
    [self addGroupWithGroup:group];
}

- (void)setMasterGroupsList:(NSMutableArray *)newList {
    if (_masterGroupsList != newList) {
        _masterGroupsList = [newList mutableCopy];
    }
}

- (id)init {
    if (self = [super init]) {
        [self initializeDefaultDataList];
        return self;
    }
    return nil;
}

- (NSUInteger)groupsCount {
    return [self.masterGroupsList count];
}

- (Group *)objectInListAtIndex:(NSUInteger)theIndex {
    return [self.masterGroupsList objectAtIndex:theIndex];
}

- (void)addGroupWithGroup:(Group *)group {
    [self.masterGroupsList addObject:group];
}

@end
