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
    
    NSMutableArray *createdGroupsList = [[NSMutableArray alloc] init];
    self.masterGroupsCreatedList = createdGroupsList;
    
    Group *group;
    NSDate *today = [NSDate date];
    group = [[Group alloc] initWithName:@"Default member poll" creatorName:@"Francesca" dateCreated:today];
    [self addGroupWithGroup:group];
    group = [[Group alloc] initWithName:@"Default creator poll" creatorName:@"Francesca" dateCreated:today];
    [self addGroupCreatedWithGroup:group];
}

- (void)setMasterGroupsList:(NSMutableArray *)newList {
    if (_masterGroupsList != newList) {
        _masterGroupsList = [newList mutableCopy];
    }
}

- (void)setMasterGroupsCreatedList:(NSMutableArray *)newList {
    if (_masterGroupsCreatedList != newList) {
        _masterGroupsCreatedList = [newList mutableCopy];
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

- (NSUInteger)groupsCreatedCount {
    return [self.masterGroupsCreatedList count];
}

- (Group *)objectInCreatedListAtIndex:(NSUInteger)theIndex {
    return [self.masterGroupsCreatedList objectAtIndex:theIndex];
}

- (void)addGroupCreatedWithGroup:(Group *)group {
    [self.masterGroupsCreatedList addObject:group];
}

@end
