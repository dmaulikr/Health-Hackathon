//
//  ValueView.m
//  Health Hackathon
//
//  Created by Patryk Drozd on 21.11.2014.
//  Copyright (c) 2014 Patryk Drozd. All rights reserved.
//

#import "ValueView.h"

@interface ValueView ()

@end

@implementation ValueView

@synthesize caloriesTextField;
@synthesize nameTextField;
@synthesize isMinus;
@synthesize information;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initVariables];
    [self addGestures];
}

-(void)setInformationLabel:(UILabel *)informationLabel
{
    informationLabel.text = self.information;
}

-(void)setCaloriesTextField:(UITextField *)textField{
    textField.keyboardType = UIKeyboardTypeNumberPad;
    caloriesTextField = textField;
    if(self.isMinus)
    {
        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
}

-(void)textFieldDidChange :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
}

-(void)setNameTextField:(UITextField *)textField{
    nameTextField = textField;
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

-(void)dismissKeyboard {
    [self.view endEditing:YES];// this will do the trick
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButtonPressed:(id)sender {
    [self sendUserDataToServer];
}

-(void)sendUserDataToServer
{
    
    NSDictionary *name = [[NSDictionary alloc]initWithObjectsAndKeys:self.nameTextField.text,@"name",nil];
    NSString *valueString = [NSString stringWithFormat:@"%@",caloriesTextField.text];
    if (self.isMinus == true) {
        valueString = [NSString stringWithFormat:@"-%@",caloriesTextField.text];
    }
    NSDictionary *value = [[NSDictionary alloc]initWithObjectsAndKeys:valueString,@"value",nil];

    NSArray *userInfoArray = [NSArray arrayWithObjects:value,name,nil];
    NSDictionary *storiesDic = [[NSDictionary alloc]initWithObjectsAndKeys:userInfoArray,@"stories",nil];
    NSDictionary *deviceDic = [[NSDictionary alloc]initWithObjectsAndKeys:storiesDic,@"device",nil];
    NSLog(@"device %@",deviceDic);
    //NSString *uuidString = [[NSUUID UUID] UUIDString];
    NSString *url = [NSString stringWithFormat:@"%@/%@",self.appDelegate.serverUrl,self.appDelegate.token];
    NSLog(@"url %@",url);
    
    __weak ValueView *weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager PUT:url parameters:deviceDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *responseArray = responseObject;
            //TODO ??
        } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *responseDict = responseObject;
            [weakSelf backToPreviousView];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self alerViewError:@"server jest skopany"];
    }];
}

-(void)backToPreviousView
{
    [self.navigationController popViewControllerAnimated:TRUE];
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


@end
