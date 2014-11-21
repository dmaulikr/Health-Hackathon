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
    [self initVariables];
    self.plus = 3000;
    self.minus = 1500;
    // Do any additional setup after loading the view.
}

-(void)initVariables
{
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
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
    [self sendUserDataToServer];
//    CGRect koloriaPlusFrame =  _KaloriaPlus.frame;
//    koloriaPlusFrame.size.height = self.plus;
//    
//    CGRect colorialMinusFrame =  _CaloriaMenus.frame;
//    colorialMinusFrame.size.height = self.minus;
//    
//    [UIView animateWithDuration:2.0 delay:0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
//        _CaloriaMenus.frame = colorialMinusFrame;
//        _KaloriaPlus.frame = koloriaPlusFrame;
//    } completion:^(BOOL finished) {
//    }];
}

-(void)sendUserDataToServer
{

    NSString *url = [NSString stringWithFormat:@"%@/%@/day",self.appDelegate.serverUrl,self.appDelegate.token];
    NSLog(@"url %@",url);
    
    __weak ValueView *weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *responseArray = responseObject;
            //TODO ??
        } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *responseDict = responseObject;
            [self prepareForAnimation:responseDict];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self alerViewError:@"server jest skopany"];
    }];
}

-(void)prepareForAnimation:(NSDictionary *)jsonDic
{
    int aPlus = [[jsonDic objectForKey:@"plus"] integerValue];
    int aMinus = [[jsonDic objectForKey:@"minus"] integerValue] * -1;
    [self animateWithPlus:aPlus minus:aMinus];
}

-(void)animateWithPlus:(int )pPlus minus:(int)mMinus
{
    NSLog(@"plus %d minus %d",pPlus,mMinus);
    CGRect koloriaPlusFrame =  _KaloriaPlus.frame;
    koloriaPlusFrame.size.height = pPlus * -1;
    
    CGRect colorialMinusFrame =  _CaloriaMenus.frame;
    colorialMinusFrame.size.height = mMinus * -1;
    
    [UIView animateWithDuration:2.0 delay:0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        _CaloriaMenus.frame = colorialMinusFrame;
        _KaloriaPlus.frame = koloriaPlusFrame;
    } completion:^(BOOL finished) {
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
