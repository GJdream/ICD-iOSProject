//
//  BaseElement.h
//  ICD_iOSPrototype
//
//  Created by Filipe Ferreira on 12/27/13.
//  Copyright (c) 2013 Filipe Ferreira. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseElement : NSObject
@property (nonatomic, retain) NSString *Id;
@property (nonatomic, retain) NSString *code;
@property (nonatomic, retain) NSString *codingHint;
@property (nonatomic, retain) NSString *exclusion;
@property (nonatomic, retain) NSString *inclusion;
@property (nonatomic, retain) NSString *note;
@property (nonatomic, retain) NSString *preferred;
@property (nonatomic, retain) NSString *introduction;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSString *innerXml;
@property (nonatomic, retain) NSString *htmlResult;
@end
