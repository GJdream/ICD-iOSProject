//
//  MainViewController.m
//  ICD_iOSPrototype
//
//  Created by Filipe Ferreira on 12/24/13.
//  Copyright (c) 2013 Filipe Ferreira. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "iOSRequest.h"
#import "Toast+UIView.h"
#import "DetailViewController.h"


@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *fetchButton;
@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;

@end


@implementation MainViewController


@synthesize theList, tableData, array, start, timeLabel, timeInterval,table;
@synthesize app, chap, show, titleCK,definitionCK,noteCK,inclusionCK,exclusionCK,codinghintCK;
@synthesize titleLabel,definitionLabel,noteLabel,inclusionLabel,exclusionLabel,codinghintLabel;
@synthesize titleBtn,definitionBtn,nodeBtn,inclusionBtn,exclusionBtn,codinghintBnt;

- (void)viewDidLoad
{
    [super viewDidLoad];
    show=YES;
    app = [[UIApplication sharedApplication] delegate];
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    titleCK = [defaults boolForKey:@"titleChecked"];
    
    [self checkTheBoxTitle];
    definitionCK = [defaults boolForKey:@"definitionChecked"];
    [self checkTheBoxDefinition];
    noteCK = [defaults boolForKey:@"noteChecked"];
    [self checkTheBoxNote];
    inclusionCK = [defaults boolForKey:@"inclusionChecked"];
    [self checkTheBoxInclusion];
    exclusionCK = [defaults boolForKey:@"exclusionChecked"];
    [self checkTheBoxExclusion];
    codinghintCK = [defaults boolForKey:@"codingChecked"];
    [self checkTheBoxCodinghint];
       
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.table indexPathForSelectedRow];
        BaseElement *b = app.listArray[indexPath.row];
        DetailViewController *d = [segue destinationViewController];
        d.loadHtml = b.htmlResult;
        d.title = [[[self.table cellForRowAtIndexPath:indexPath] textLabel ]text];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"RecipeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}

-(void)fetchAddress:(NSString *)address
{
    NSLog(@"Loading Address: %@",address);
    [iOSRequest requestToPath:address titleC:titleCK definitionC:definitionCK noteC:noteCK
                   inclusionC:inclusionCK exclusionC:exclusionCK codingC:codinghintCK
                 onCompletion:^(NSString *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(error){
                [self stopFetching:@"Failed to Fetch!"];
                NSLog(@"%@",error);
            }else{
                [self stopFetching:result];
                
            }
        });
        
    }];
    
}


- (IBAction)fetch:(id)sender
{
    
    [self startFetching];
    chap = [self.addressField.text integerValue];
    chap--;
    [self fetchAddress:self.addressField.text];
}

-(void)startFetching
{
    NSLog(@"Fetching...");
    [self hideAll];
    [self.addressField resignFirstResponder];
    [self.loading startAnimating];
    [self setStart:[NSDate date]];
    NSLog(@"%@",self.start);
    self.fetchButton.enabled = NO;
    
}

-(void)stopFetching:(NSString *)result
{
    
    NSTimeInterval time = [self.start timeIntervalSinceNow];
    float a = fabsf(time);
    timeLabel.text = [NSString stringWithFormat:@"%@%.2f%@",@"Time elapsed: ",a , @" seconds"];
    NSMutableArray *are = [[NSMutableArray alloc] init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *add = [defaults stringForKey:@"addressURL"];
    NSString *inToast=@"";
    
        for (BaseElement *object in [app.listArray copy] ){
            
            if([add rangeOfString:@"blocks"].location ==NSNotFound){
                inToast=@"Chapter ";
                [are addObject:[NSString stringWithFormat:@"%@%@",inToast,object.code]];
            }else {
                  inToast=@"Block ";
                 [are addObject:[NSString stringWithFormat:@"%@%@",inToast,object.code]];
            }
        
       
    }
    tableData = are;
    
    [table reloadData];
    

     
    NSLog(@"Done Fetching!");

   
     
//    @try {
//      theList = [app.listArray objectAtIndex:0];
//    }
//    @catch (NSException *exception) {
//        UIAlertView * newAlert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Chapters range 1-22" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
//        [newAlert show];
//
//    }
   [self.view makeToast:[NSString stringWithFormat:@"%@%i",@"Returned Codes: ",[app.listArray count]]];
    [self.loading stopAnimating];
    self.fetchButton.enabled = YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) checkTheBoxTitle {
    if (!titleCK) {
        [titleBtn setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
    }
    
    else if (titleCK) {
        
        [titleBtn setImage:[UIImage imageNamed:@"checkBoxMarked.png"] forState:UIControlStateNormal];
    }
}
- (void) checkTheBoxDefinition {
    if (!definitionCK) {
        [definitionBtn setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
    }
    
    else if (definitionCK) {
        
        [definitionBtn setImage:[UIImage imageNamed:@"checkBoxMarked.png"] forState:UIControlStateNormal];
    }
}

- (void) checkTheBoxNote {
    if (!noteCK) {
        [nodeBtn setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
    }
    
    else if (noteCK) {
        
        [nodeBtn setImage:[UIImage imageNamed:@"checkBoxMarked.png"] forState:UIControlStateNormal];
    }
}
- (void) checkTheBoxInclusion {
    if (!inclusionCK) {
        [inclusionBtn setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
    }
    
    else if (inclusionCK) {
        
        [inclusionBtn setImage:[UIImage imageNamed:@"checkBoxMarked.png"] forState:UIControlStateNormal];
    }
}
- (void) checkTheBoxExclusion {
    if (!exclusionCK) {
        [exclusionBtn setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
    }
    
    else if (exclusionCK) {
        
        [exclusionBtn setImage:[UIImage imageNamed:@"checkBoxMarked.png"] forState:UIControlStateNormal];
    }
}
- (void) checkTheBoxCodinghint {
    if (!codinghintCK) {
        [codinghintBnt setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
    }
    
    else if (codinghintCK) {
        
        [codinghintBnt setImage:[UIImage imageNamed:@"checkBoxMarked.png"] forState:UIControlStateNormal];
    }
}

- (void) hideAll {
    
        
    
        show=YES;
        titleLabel.hidden=YES;
        definitionLabel.hidden=YES;
        inclusionLabel.hidden=YES;
        exclusionLabel.hidden=YES;
        noteLabel.hidden=YES;
        codinghintLabel.hidden=YES;
        
        titleBtn.hidden=YES;
        definitionBtn.hidden=YES;
        nodeBtn.hidden=YES;
        inclusionBtn.hidden=YES;
        exclusionBtn.hidden=YES;
        codinghintBnt.hidden=YES;
        table.hidden=NO;
    

}

- (IBAction)advancedButton:(id)sender {


    if (show) {
        titleLabel.hidden=NO;
        definitionLabel.hidden=NO;
         inclusionLabel.hidden=NO;
         exclusionLabel.hidden=NO;
         noteLabel.hidden=NO;
         codinghintLabel.hidden=NO;
        
         titleBtn.hidden=NO;
         definitionBtn.hidden=NO;
         nodeBtn.hidden=NO;
         inclusionBtn.hidden=NO;
         exclusionBtn.hidden=NO;
         codinghintBnt.hidden=NO;
        table.hidden=YES;
        show=NO;
        
    }
    else if(!show)
    {
    show=YES;
    titleLabel.hidden=YES;
    definitionLabel.hidden=YES;
    inclusionLabel.hidden=YES;
    exclusionLabel.hidden=YES;
    noteLabel.hidden=YES;
    codinghintLabel.hidden=YES;
    
    titleBtn.hidden=YES;
    definitionBtn.hidden=YES;
    nodeBtn.hidden=YES;
    inclusionBtn.hidden=YES;
    exclusionBtn.hidden=YES;
    codinghintBnt.hidden=YES;
    table.hidden=NO;
    }
    
}
- (IBAction)titleCheck:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (!titleCK) {
        [titleBtn setImage:[UIImage imageNamed:@"checkBoxMarked.png"] forState:UIControlStateNormal];
        titleCK = YES;
        [defaults setBool:titleCK forKey:@"titleChecked"];
    }
    
    else if (titleCK) {
        [titleBtn setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
        titleCK = NO;
        [defaults setBool:titleCK forKey:@"titleChecked"];
    }
    
    [defaults synchronize];
}
- (IBAction)noteCheck:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (!noteCK) {
        [nodeBtn setImage:[UIImage imageNamed:@"checkBoxMarked.png"] forState:UIControlStateNormal];
        noteCK = YES;
        [defaults setBool:noteCK forKey:@"noteChecked"];
    }
    
    else if (noteCK) {
        [nodeBtn setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
        noteCK = NO;
        [defaults setBool:noteCK forKey:@"noteChecked"];
    }
    
    [defaults synchronize];
}
- (IBAction)definitionCheck:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (!definitionCK) {
        [definitionBtn setImage:[UIImage imageNamed:@"checkBoxMarked.png"] forState:UIControlStateNormal];
        definitionCK = YES;
        [defaults setBool:definitionCK forKey:@"definitionChecked"];
    }
    
    else if (definitionCK) {
        [definitionBtn setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
        definitionCK = NO;
        [defaults setBool:definitionCK forKey:@"definitionChecked"];
    }
    
    [defaults synchronize];
}
- (IBAction)inclusionCheck:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (!inclusionCK) {
        [inclusionBtn setImage:[UIImage imageNamed:@"checkBoxMarked.png"] forState:UIControlStateNormal];
        inclusionCK = YES;
        [defaults setBool:inclusionCK forKey:@"inclusionChecked"];
    }
    
    else if (inclusionCK) {
        [inclusionBtn setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
        inclusionCK = NO;
        [defaults setBool:inclusionCK forKey:@"inclusionChecked"];
    }
    
    [defaults synchronize];
}
- (IBAction)exclusionCheck:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (!exclusionCK) {
        [exclusionBtn setImage:[UIImage imageNamed:@"checkBoxMarked.png"] forState:UIControlStateNormal];
        exclusionCK = YES;
        [defaults setBool:exclusionCK forKey:@"exclusionChecked"];
    }
    
    else if (exclusionCK) {
        [exclusionBtn setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
        exclusionCK = NO;
        [defaults setBool:exclusionCK forKey:@"exclusionChecked"];
    }
    
    [defaults synchronize];
}
- (IBAction)codinghintCheck:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (!codinghintCK) {
        [codinghintBnt setImage:[UIImage imageNamed:@"checkBoxMarked.png"] forState:UIControlStateNormal];
        codinghintCK = YES;
        [defaults setBool:codinghintCK forKey:@"codingChecked"];
    }
    
    else if (codinghintCK) {
        [codinghintBnt setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
        codinghintCK = NO;
        [defaults setBool:codinghintCK forKey:@"codingChecked"];
    }
    
    [defaults synchronize];
}

@end
