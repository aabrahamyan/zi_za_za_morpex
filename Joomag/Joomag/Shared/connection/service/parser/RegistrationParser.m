//
//  RegistrationParser.m
//  Joomag
//
//  Created by Armen Abrahamyan on 10/20/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "RegistrationParser.h"

@implementation RegistrationParser




- (NSDictionary * ) parseRegistration: (id) responseObject {

    NSError *jsonParsingError = nil;
    
   NSDictionary * json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&jsonParsingError];
    NSLog(@"JSON = %@", json);
    
    return json;
    
}

@end
