//
//  MagazinesListParser.h
//  Joomag
//
//  Created by Armen Abrahamyan on 8/14/13.
//  Copyright (c) 2013 Joomag. All rights reserved.
//

#import "BaseParser.h"

@interface MagazinesListParser : BaseParser {

    NSString * upperLeverElem;
    
    NSMutableDictionary * magazinesDictionary;
}


- (void) bindArrayToMappingObject;

@end
