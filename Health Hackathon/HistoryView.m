//
//  HistoryView.m
//  Health Hackathon
//
//  Created by Patryk Drozd on 21.11.2014.
//  Copyright (c) 2014 Patryk Drozd. All rights reserved.
//

#import "HistoryView.h"

@interface HistoryView ()

@end

@implementation HistoryView

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_ScrollHistoria setScrollEnabled:YES];
    [_ScrollHistoria setContentSize:CGSizeMake(375, 930)];
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
