//
//  UserInformationModel.h
//  Health Hackathon
//
//  Created by Patryk Drozd on 21.11.2014.
//  Copyright (c) 2014 Patryk Drozd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInformationModel : NSObject

@property(nonatomic, strong) NSString *weight;
@property(nonatomic, strong) NSString *heigh;
@property(nonatomic, strong) NSString *age;
@property(nonatomic, strong) NSString *sex;

-(id)initWithWeight:(NSString *)aWeight height:(NSString *)aHeight age:(NSString *)aAge sex:(NSString *)aSex;

@end
