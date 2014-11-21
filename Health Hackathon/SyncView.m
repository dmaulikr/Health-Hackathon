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
    //[self performSegueWithIdentifier:@"syncToLogin" sender:self];

    [self initVariables];
    [self manageLogin];
}

-(void)manageLogin
{
    if ([self isTokenAvailable]) {
        NSUserDefaults *userSavedData = [[NSUserDefaults alloc]init];
        NSString *token = [userSavedData objectForKey:@"token"];
        self.appDelegate.token = token;
        [self performSegueWithIdentifier:@"syncToDashboard" sender:self];
    }
    else
    {
        [self performSegueWithIdentifier:@"syncToLogin" sender:self];
    }
}

-(BOOL)isTokenAvailable
{
    NSUserDefaults *userSavedData = [[NSUserDefaults alloc]init];
    if ([userSavedData objectForKey:@"token"] != nil) {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(void)initVariables
{
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

//-(void)login
//{
//    
//    __weak SyncView *weakSelf = self;
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    NSString *uuidString = [[NSUUID UUID] UUIDString];
//    NSString *url = [NSString stringWithFormat:@"%@/%@",self.appDelegate.serverUrl,uuidString];
//    NSLog(@"url %@",url);
//
//    NSDictionary *deviceDic = [[NSDictionary alloc]initWithObjectsAndKeys:userInfoDic,@"device",nil];
//    [manager GET:url parameters:deviceDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//        if ([responseObject isKindOfClass:[NSArray class]]) {
//            NSArray *responseArray = responseObject;
//            // No Array ?
//        } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            NSDictionary *responseDict = responseObject;
//            [weakSelf moveToNextView:responseDict];
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//        [weakSelf alerViewError:@"server jest skopany"];
//    }];
//}

//-(void)moveToNextView:(NSDictionary *)responseDic
//{
//    if ([responseDic objectForKey:@"token"] != nil) {
//        NSString *token = [responseDic objectForKey:@"token"];
//        NSUserDefaults *userSavedData = [[NSUserDefaults alloc]init];
//        [userSavedData setObject:token forKey:@"token"];
//        self.appDelegate.token = token;
//        [self performSegueWithIdentifier:@"syncToDashboard" sender:self];
//    }
//    else
//    {
//        [self performSegueWithIdentifier:@"syncToLogin" sender:self];
//    }
//}

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
