//
//  SettingsViewController.h
//  ICD_iOSPrototype
//
//  Created by Filipe Ferreira on 12/25/13.
//  Copyright (c) 2013 Filipe Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UITextField *addressPoint;

- (IBAction)endpointSet:(id)sender;
@end
