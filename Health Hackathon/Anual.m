//
//  Anual.m
//  Health Hackathon
//
//  Created by Erinson Villarroel on 11/21/14.
//  Copyright (c) 2014 Patryk Drozd. All rights reserved.
//

#import "Anual.h"

@interface Anual ()
@property (weak, nonatomic) IBOutlet UIView *Jan;
@property (weak, nonatomic) IBOutlet UIView *Feb;
@property (weak, nonatomic) IBOutlet UIView *Mar;
@property (weak, nonatomic) IBOutlet UIView *Apr;
@property (weak, nonatomic) IBOutlet UIView *May;
@property (weak, nonatomic) IBOutlet UIView *Jun;
@property (weak, nonatomic) IBOutlet UIView *Jul;
@property (weak, nonatomic) IBOutlet UIView *Aug;
@property (weak, nonatomic) IBOutlet UIView *Sep;
@property (weak, nonatomic) IBOutlet UIView *Oct;
@property (weak, nonatomic) IBOutlet UIView *Nov;
@property (weak, nonatomic) IBOutlet UIView *Dec;

@end


@implementation Anual


-(BOOL)prefersStatusBarHidden{
    return YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _Jan.frame = (CGRectMake(48, 37, 278, 19));
    } completion:^(BOOL finished) {
    }];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
