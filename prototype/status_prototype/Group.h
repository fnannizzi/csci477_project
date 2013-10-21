//
//  Group.h
//  status_prototype
//
//  Created by Francesca Nannizzi on 10/21/13.
//  Copyright (c) 2013 Francesca Nannizzi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject

@property NSString *name;
@property NSString *creatorName;
@property NSUInteger *size;
@property NSDate *dateCreated;
@property NSMutableArray *members;

-(id)initWithName:(NSString *)name creatorName:(NSString *)creatorName dateCreated:(NSDate *)dateCreated;

@end

