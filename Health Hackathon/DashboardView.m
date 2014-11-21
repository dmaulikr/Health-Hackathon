//
//  DashboardView.m
//  Health Hackathon
//
//  Created by Patryk Drozd on 21.11.2014.
//  Copyright (c) 2014 Patryk Drozd. All rights reserved.
//

#import "DashboardView.h"

@interface DashboardView ()

@end

@implementation DashboardView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     Get the new view controller using [segue destinationViewController].
     Pass the selected object to the new view controller.
}
*/

- (IBAction)valueMinusPressed:(id)sender {
    [self performSegueWithIdentifier:@"dashboardToValue" sender:self];
}

- (IBAction)valuePlusPressed:(id)sender {
    [self performSegueWithIdentifier:@"dashboardToValue" sender:self];
}

- (IBAction)historyButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"dashboardToHistory" sender:self];
}
@end
