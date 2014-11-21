//
//  DashboardView.m
//  Health Hackathon
//
//  Created by Patryk Drozd on 21.11.2014.
//  Copyright (c) 2014 Patryk Drozd. All rights reserved.
//

#import "DashboardView.h"

@interface DashboardView ()
@property (weak, nonatomic) IBOutlet UIView *KaloriaPlus;
@property (weak, nonatomic) IBOutlet UIView *CaloriaMenus;

@end

@implementation DashboardView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.plus = 3000;
    self.minus = 1500;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    CGRect koloriaPlusFrame =  _KaloriaPlus.frame;
    koloriaPlusFrame.size.height = 0;
    _KaloriaPlus.frame = koloriaPlusFrame;
    
    CGRect colorialMinusFrame =  _CaloriaMenus.frame;
    colorialMinusFrame.size.height = 0;
    _CaloriaMenus.frame = colorialMinusFrame;
}

-(void)viewDidAppear:(BOOL)animated
{
    
    CGRect koloriaPlusFrame =  _KaloriaPlus.frame;
    koloriaPlusFrame.size.height = self.plus;
    
    CGRect colorialMinusFrame =  _CaloriaMenus.frame;
    colorialMinusFrame.size.height = self.minus;
    
    [UIView animateWithDuration:2.0 delay:0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        _CaloriaMenus.frame = colorialMinusFrame;
        _KaloriaPlus.frame = koloriaPlusFrame;
    } completion:^(BOOL finished) {
    }];
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
