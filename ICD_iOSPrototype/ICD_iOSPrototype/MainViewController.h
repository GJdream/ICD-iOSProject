//
//  MainViewController.h
//  ICD_iOSPrototype
//
//  Created by Filipe Ferreira on 12/24/13.
//  Copyright (c) 2013 Filipe Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodeICD.h"
#import "MainAppDelegate.h"

@interface MainViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *definitionLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;
@property (weak, nonatomic) IBOutlet UILabel *inclusionLabel;
@property (weak, nonatomic) IBOutlet UILabel *exclusionLabel;
@property (weak, nonatomic) IBOutlet UILabel *codinghintLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic, retain) MainAppDelegate *app;

@property (nonatomic, retain) CodeICD *theList;

@property (nonatomic,strong) NSArray *tableData;
@property (assign) NSMutableArray *array;
@property (nonatomic,strong) NSDate *start;
@property (nonatomic,assign) NSTimeInterval *timeInterval;


@property (assign) BOOL show;
@property (assign) BOOL titleCK;
@property (assign) BOOL definitionCK;
@property (assign) BOOL noteCK;
@property (assign) BOOL inclusionCK;
@property (assign) BOOL exclusionCK;
@property (assign) BOOL codinghintCK;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
- (IBAction)advancedButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *table;



@property (weak, nonatomic) IBOutlet UIButton *titleBtn;
- (IBAction)titleCheck:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *definitionBtn;
- (IBAction)definitionCheck:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *nodeBtn;
- (IBAction)noteCheck:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *inclusionBtn;
- (IBAction)inclusionCheck:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *exclusionBtn;
- (IBAction)exclusionCheck:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *codinghintBnt;
- (IBAction)codinghintCheck:(id)sender;



@end
