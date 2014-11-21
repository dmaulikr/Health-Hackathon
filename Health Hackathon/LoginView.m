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

-(void)setAgeTextField:(UITextField *)textField
{
    textField.keyboardType = UIKeyboardTypeNumberPad;
}

-(void)setWeightTextField:(UITextField *)textField{
    textField.keyboardType = UIKeyboardTypeNumberPad;
}

-(void)setHeightTextField:(UITextField *)textField
{
    textField.keyboardType = UIKeyboardTypeNumberPad;
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
    [self sendUserDataToServer];
    //[self performSegueWithIdentifier:@"loginToDashboard" sender:self];
}

-(void)sendUserDataToServer
{
    
    UserInformationModel *userInfo = [self createUserInfoObject];
    
    
    
    NSDictionary *userInfoDic = [[NSDictionary alloc]initWithObjectsAndKeys:userInfo.heigh,@"height",userInfo.weight,@"weight",userInfo.age,@"age",userInfo.sex,@"sex", nil];
    NSDictionary *deviceDic = [[NSDictionary alloc]initWithObjectsAndKeys:userInfoDic,@"device",nil];

    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:deviceDic
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSString *uuidString = [[NSUUID UUID] UUIDString];
    NSString *url = [NSString stringWithFormat:@"%@/%@",self.appDelegate.serverUrl,uuidString];
    NSLog(@"url %@",url);
    
    __weak LoginView *weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:url parameters:deviceDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *responseArray = responseObject;
            //TODO ??
        } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *responseDict = responseObject;
            [weakSelf LoginSuccessWithToken:responseDict];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self alerViewError:@"server jest skopany"];
    }];
}

-(void)alerViewError:(NSString *)error
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Connection Error" message:error delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry",nil];
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self sendUserDataToServer];
    }
}

-(UserInformationModel *)createUserInfoObject
{
    float heightFloat = [heightTextField.text floatValue];
    NSString *heigh = [NSString stringWithFormat:@"%f.02f",heightFloat];
    float weidthFloat = [weightTextField.text floatValue];
    NSString *weight = [NSString stringWithFormat:@"%f.02f",weidthFloat];
    NSString *age = [NSString stringWithFormat:@"%d",[ageTextField.text intValue]];
    NSString *sex = [NSString stringWithFormat:@"%d",sexSegment.selectedSegmentIndex];
    
    
    UserInformationModel *userInfo = [[UserInformationModel alloc]initWithWeight:weight height:heigh age:age sex:sex];
    NSLog(@"heigh %@",userInfo.heigh);
    NSLog(@"weight %@",userInfo.weight);
    NSLog(@"age %@",userInfo.age);
    NSLog(@"sex %@",userInfo.sex);

    return userInfo;
}

-(void)LoginSuccessWithToken:(NSDictionary *)responseTokenDic
{
    NSString *token = [responseTokenDic objectForKey:@"token"];
    self.appDelegate.token = token;
    [self performSegueWithIdentifier:@"loginToDashboard" sender:self];
}
@end
