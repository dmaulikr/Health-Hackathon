//
//  SyncView.m
//  Health Hackathon
//
//  Created by Patryk Drozd on 21.11.2014.
//  Copyright (c) 2014 Patryk Drozd. All rights reserved.
//

#import "SyncView.h"

@interface SyncView ()

@end

@implementation SyncView

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self performSegueWithIdentifier:@"syncToLogin" sender:self];

    [self initVariables];
    [self login];
}

-(void)initVariables
{
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)login
{
    __weak SyncView *weakSelf = self;

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    NSString *uuidString = [[NSUUID UUID] UUIDString];
    NSLog(@"uuid %@",uuidString);
    //NSDictionary *parameters = @{@"uuidString": @"device_no"};
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",self.appDelegate.serverUrl,uuidString];
    NSLog(@"url %@",url);

    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *responseArray = responseObject;
            //TODO ??
        } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *responseDict = responseObject;
            [weakSelf moveToNextView];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)moveToNextView
{
    [self performSegueWithIdentifier:@"syncToLogin" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
