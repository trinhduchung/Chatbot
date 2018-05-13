//
//  AIRequestEntity.m
//  ApiAI
//
//  Created by Kuragin Dmitriy on 22/05/15.
//  Copyright (c) 2015 Kuragin Dmitriy. All rights reserved.
//

#import "AIRequestEntity.h"
#import "AIRequestEntity_Private.h"

@implementation AIRequestEntity

- (AI_NONNULL instancetype)initWithName:(NSString * __AI_NONNULL)name
                             andEntries:(NSArray AI_GENERICS_1(AIRequestEntry *) * __AI_NONNULL)entries
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _entries = [entries copy];
    }
    
    return self;
}

- (NSDictionary *)dictionaryPresentation
{
    NSMutableArray *entries = [NSMutableArray array];
    [_entries enumerateObjectsUsingBlock:^(AIRequestEntry *obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *entry = @{
                                @"value": obj.value,
                                @"synonyms": obj.synonyms
                                };
        
        [entries addObject:entry];
    }];
    
    NSDictionary *entity = @{
                             @"name": self.name,
                             @"entries": [entries copy]
                             };
    
    return entity;
}

@end
