//
//  UserInformationModel.h
//  Health Hackathon
//
//  Created by Patryk Drozd on 21.11.2014.
//  Copyright (c) 2014 Patryk Drozd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInformationModel : NSObject

@property(nonatomic) float weight;
@property(nonatomic) float heigh;
@property(nonatomic) int age;
@property(nonatomic) int sex;

-(id)initWithWeight:(float)aWeight height:(float)aHeight age:(int)aAge sex:(int)aSex;

@end
