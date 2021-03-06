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
    
    if ([elementName isEqualToString:@"ArrayOfCodeICD"]) {
        
        app.listArray = [[NSMutableArray alloc] init];
    }
    else if([elementName isEqualToString:@"CodeICD" ] ){
        
        codeICD = [[CodeICD alloc] init];
        
              
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
    
    if ([elementName isEqualToString:@"ArrayOfCodeICD"]) {
        return;
    }
    
    
    if ([elementName isEqualToString:@"CodeICD"]) {
        [app.listArray addObject:codeICD];
        
        codeICD = nil;
        
    }
    

    else
        [codeICD setValue:currentElementValue forKey:elementName];
    
    currentElementValue = nil;
    
}

@end
