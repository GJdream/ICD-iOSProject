//
//  Parser.h
//  ICD_iOSPrototype
//
//  Created by Filipe Ferreira on 12/25/13.
//  Copyright (c) 2013 Filipe Ferreira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Category.h"
#import "Chapter.h"
#import "MainAppDelegate.h"

@interface Parser : NSObject <NSXMLParserDelegate>{
    MainAppDelegate *app;
    BaseElement *theList;
    NSMutableString *currentElementValue;
}

-(id)initParser;
@end
