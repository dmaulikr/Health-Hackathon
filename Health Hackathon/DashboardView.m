//
//  DashboardView.m
//  Health Hackathon
//
//  Created by Patryk Drozd on 21.11.2014.
//  Copyright (c) 2014 Patryk Drozd. All rights reserved.
//

#import "DashboardView.h"
#import "ValueView.h"
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
    koloriaPlusFrame.origin.y = 618;

    
    _KaloriaPlus.frame = koloriaPlusFrame;
    
    CGRect colorialMinusFrame =  _CaloriaMenus.frame;
    colorialMinusFrame.size.height = 0;
    colorialMinusFrame.origin.y = 618;

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


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"dashboardToValue"])
    {
        ValueView *vc = [segue destinationViewController];
        NSLog(@"isMinusPressed%hhd",self.isMinusPressed);
        vc.isMinus = self.isMinusPressed;
        if (self.isMinusPressed) {
            [vc setInformation:@"Minus"];
        }
        else
        {
            [vc setInformation:@"Plus"];
        }
        //[vc setIsMinus:self.isMinusPressed];
    }
}


- (IBAction)valueMinusPressed:(id)sender {
    self.isMinusPressed = YES;
    [self performSegueWithIdentifier:@"dashboardToValue" sender:self];
}

- (IBAction)valuePlusPressed:(id)sender {
    self.isMinusPressed = NO;
    [self performSegueWithIdentifier:@"dashboardToValue" sender:self];
}

- (IBAction)historyButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"dashboardToHistory" sender:self];
}
@end
