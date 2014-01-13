//
//  SettingsViewController.m
//  ICD_iOSPrototype
//
//  Created by Filipe Ferreira on 12/25/13.
//  Copyright (c) 2013 Filipe Ferreira. All rights reserved.
//

#import "SettingsViewController.h"
#import "SWRevealViewController.h"
@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize addressPoint;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    addressPoint.text = [defaults stringForKey:@"addressURL"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)endpointSet:(id)sender {
    
    UIAlertView * newAlert=[[UIAlertView alloc] initWithTitle:@"Change Endpoint Address" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [newAlert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField *field=[newAlert textFieldAtIndex:0];
    field.text=addressPoint.text;
    [newAlert show];
}
- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [addressPoint setText:[[alertView textFieldAtIndex:0] text]];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[[alertView textFieldAtIndex:0] text] forKey:@"addressURL"];
        [defaults synchronize];
    }
   
}
@end
