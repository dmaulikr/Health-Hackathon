//
//  DashboardView.h
//  Health Hackathon
//
//  Created by Patryk Drozd on 21.11.2014.
//  Copyright (c) 2014 Patryk Drozd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface DashboardView : UIViewController
@property (nonatomic) BOOL isMinusPressed;
@property (strong, nonatomic) AppDelegate *appDelegate;

- (IBAction)valueMinusPressed:(id)sender;
- (IBAction)valuePlusPressed:(id)sender;
- (IBAction)historyButtonPressed:(id)sender;
@property(nonatomic) int plus;
@property(nonatomic) int minus;

@end
