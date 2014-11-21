//
//  LoginView.m
//  Health Hackathon
//
//  Created by Patryk Drozd on 21.11.2014.
//  Copyright (c) 2014 Patryk Drozd. All rights reserved.
//

#import "LoginView.h"

@interface LoginView ()

@end

@implementation LoginView

@synthesize ageTextField;
@synthesize weightTextField;
@synthesize sexSegment;
@synthesize heightTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initVariables];
    [self addGestures];
}

-(void)initVariables
{
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)addGestures
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];// this will do the trick
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)nextButtonPressed:(id)sender {
    //[self sendUserDataToServer];
    [self performSegueWithIdentifier:@"loginToDashboard" sender:self];
}

-(void)sendUserDataToServer
{
    __weak LoginView *weakSelf = self;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    
    //UserInformationModel *userInfo = [self initUserData];
    
    //NSDictionary *userData
    NSString *url = [NSString stringWithFormat:@"%@/",self.appDelegate];
    NSLog(@"url %@",url);
    
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *responseArray = responseObject;
            [weakSelf LoginSuccess];
            //TODO ??
        } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *responseDict = responseObject;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

//- (UserInformationModel *)initUserData
//{
//    UserInformationModel *userInfo = [[UserInformationModel alloc]init];
//    return userInfo;
//}

-(void)LoginSuccess
{
    [self performSegueWithIdentifier:@"loginToDashboard" sender:self];
}
@end
