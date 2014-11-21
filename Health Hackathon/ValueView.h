//
//  ValueView.h
//  Health Hackathon
//
//  Created by Patryk Drozd on 21.11.2014.
//  Copyright (c) 2014 Patryk Drozd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AFNetworking.h"
@interface ValueView : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *informationLabel;
@property (weak, nonatomic) IBOutlet UITextField *caloriesTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) NSString *information;
@property (nonatomic) bool isMinus;
@property (strong, nonatomic) AppDelegate *appDelegate;
- (IBAction)saveButtonPressed:(id)sender;

@end
