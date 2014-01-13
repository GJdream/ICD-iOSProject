//
//  DetailViewController.h
//  ICD_iOSPrototype
//
//  Created by Filipe Ferreira on 12/29/13.
//  Copyright (c) 2013 Filipe Ferreira. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (nonatomic,strong) NSString *loadHtml;
@end
