//
//  UserInformationModel.m
//  Health Hackathon
//
//  Created by Patryk Drozd on 21.11.2014.
//  Copyright (c) 2014 Patryk Drozd. All rights reserved.
//

#import "UserInformationModel.h"

@implementation UserInformationModel

@synthesize weight;
@synthesize heigh;
@synthesize age;
@synthesize sex;

-(instancetype)init
{
    self = [super init];
    if(self)
    {
       self = [self initWithWeight:0 height:0 age:0 sex:0];
    }
    return self;
}

-(id)initWithWeight:(NSString *)aWeight height:(NSString *)aHeight age:(NSString *)aAge sex:(NSString *)aSex
{
    self = [super init];
    if (self) {
        self.weight = aWeight;
        self.heigh = aHeight;
        self.age = aAge;
        self.sex = aSex;
    }
    return self;
}

@end
