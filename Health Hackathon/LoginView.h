//
//  LoginView.h
//  Health Hackathon
//
//  Created by Patryk Drozd on 21.11.2014.
//  Copyright (c) 2014 Patryk Drozd. All rights reserved.
//

#import "ViewController.h"

@interface LoginView : ViewController
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

- (IBAction)nextButtonPressed:(id)sender;
@end
