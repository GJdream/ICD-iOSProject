//
//  Parser.m
//  ICD_iOSPrototype
//
//  Created by Filipe Ferreira on 12/25/13.
//  Copyright (c) 2013 Filipe Ferreira. All rights reserved.
//

#import "Parser.h"

@implementation Parser


-(id) initParser {
    
    if (self == [super init]) {
        
        app = (MainAppDelegate *)[[UIApplication sharedApplication]delegate];
        
    }
    return self;
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:@"ArrayOfCategory"]) {
        
        app.listArray = [[NSMutableArray alloc] init];
    }
    else if([elementName isEqualToString:@"Category" ] ){
        
        theList = [[BaseElement alloc] init];
        
              
    }
    else if ([elementName isEqualToString:@"ArrayOfChapter"]) {
        
        app.listArray = [[NSMutableArray alloc] init];
    }
    else if([elementName isEqualToString:@"Chapter" ] ){
        
        theList = [[Chapter alloc] init];
        
        
    }
    else if ([elementName isEqualToString:@"ArrayOfBlock"]) {
        
        app.listArray = [[NSMutableArray alloc] init];
    }
    else if([elementName isEqualToString:@"Block" ] ){
        
        theList = [[Chapter alloc] init];
        
        
    }
    
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    if (!currentElementValue) {
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    }
    else
        [currentElementValue appendString:string];
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if ([elementName isEqualToString:@"ArrayOfCategory"]) {
        return;
    }
    
    
    if ([elementName isEqualToString:@"Category"]) {
        [app.listArray addObject:theList];
        
        theList = nil;
        
    }
    if ([elementName isEqualToString:@"ArrayOfChapter"]) {
        return;
    }
    
    
    if ([elementName isEqualToString:@"Chapter"]) {
        [app.listArray addObject:theList];
        
        theList = nil;
        
    }
    if ([elementName isEqualToString:@"ArrayOfBlock"]) {
        return;
    }
    
    
    if ([elementName isEqualToString:@"Block"]) {
        [app.listArray addObject:theList];
        
        theList = nil;
        
    }

    else
        [theList setValue:currentElementValue forKey:elementName];
    
    currentElementValue = nil;
    
}

@end
