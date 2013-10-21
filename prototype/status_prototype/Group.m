//
//  Group.m
//  status_prototype
//
//  Created by Francesca Nannizzi on 10/21/13.
//  Copyright (c) 2013 Francesca Nannizzi. All rights reserved.
//

#import "Group.h"

@implementation Group

-(id)initWithName:(NSString *)name creatorName:(NSString *)creatorName dateCreated:(NSDate *)dateCreated{
    self = [super init];
    if (self) {
        _name = name;
        _creatorName = creatorName;
        _dateCreated = dateCreated;
        return self;
    }
    return nil;
}

@end
