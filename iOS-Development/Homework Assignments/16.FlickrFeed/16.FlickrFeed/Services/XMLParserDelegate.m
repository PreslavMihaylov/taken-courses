//
//  XMLParserDelegate.m
//  16.FlickrFeed
//
//  Created by P. Mihaylov on 5/25/15.
//  Copyright (c) 2015 Mihaylov. All rights reserved.
//

#import "XMLParserDelegate.h"
#import "Entry.h"
#import "ServerManager.h"

@interface XMLParserDelegate()

@property (nonatomic) BOOL *hasStartedEntry;

@property (nonatomic) NSMutableArray *elementsToSave;

@property (nonatomic) NSString *currentElement;

@property (nonatomic) NSString *identifier;
@property (nonatomic) NSString *original;
@property (nonatomic) NSDate *published;
@property (nonatomic) NSString *imageURL;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *author;

@end

@implementation XMLParserDelegate {
    Entry *_entry;
}

- (void) parserDidStartDocument:(NSXMLParser *)parser {
    // NSLog(@"parserDidStartDocument");
    self.elementsToSave = [[NSMutableArray alloc] init];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    // NSLog(@"didStartElement --> %@", elementName);
    
    if ([elementName isEqualToString:@"entry"]) {
        self.hasStartedEntry = YES;
        
    } else if (self.hasStartedEntry && [elementName isEqualToString:@"link"]) {
        if ([attributeDict[@"type"] isEqualToString:@"text/html"]) {
            self.original = attributeDict[@"href"];
        } else if ([attributeDict[@"type"] isEqualToString:@"image/jpeg"]) {
            self.imageURL = attributeDict[@"href"];
        }
    }
    
    self.currentElement = elementName;
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    // NSLog(@"foundCharacters --> %@", string);
    
    if ([self.currentElement isEqualToString:@"published"] && self.hasStartedEntry) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
        NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [dateFormat setLocale:posix];
        NSDate *date = [dateFormat dateFromString:string];
        
        if (date) {
            self.published = date;
        }
    } else if ([self.currentElement isEqualToString:@"title"] && self.hasStartedEntry) {
        if (string && !self.title) {
            self.title = string;
        }
    } else if ([self.currentElement isEqualToString:@"name"] && self.hasStartedEntry) {
        if (string && !self.author) {
            self.author = string;
        }
    } else if ([self.currentElement isEqualToString:@"id"] && self.hasStartedEntry) {
        if (string && !self.identifier) {
            self.identifier = string;
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    // NSLog(@"didEndElement   --> %@", elementName);
    
    if ([elementName isEqualToString:@"entry"]) {
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Entry"];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier = %@", self.identifier];
        [request setPredicate:predicate];
        
        NSArray *result = [[ServerManager sharedInstance].masterContext executeFetchRequest:request error:nil];
        if ([result count] == 0) {
            NSDictionary *dictionary = [[NSDictionary alloc]
                                        initWithObjects:@[self.original, self.imageURL, self.author, self.published, self.identifier, self.title]
                                        forKeys:@[@"original", @"imageURL", @"author", @"published", @"identifier", @"title"]];
            
            [self.elementsToSave addObject:dictionary];
        } else {
            NSLog(@"Duplicate!");
        }
        
        self.hasStartedEntry = NO;
        
        self.original = nil;
        self.imageURL = nil;
        self.author = nil;
        self.published = nil;
        self.identifier = nil;
        self.title = nil;
    }
}

- (void) parserDidEndDocument:(NSXMLParser *)parser {
    // NSLog(@"parserDidEndDocument");
    
    dispatch_async(dispatch_get_main_queue(), ^() {
        NSManagedObjectContext *workerContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        
        [workerContext setParentContext:[ServerManager sharedInstance].mainContext];
        
        for (NSDictionary *attributesDict in self.elementsToSave) {
            Entry *entry = [NSEntityDescription insertNewObjectForEntityForName:@"Entry" inManagedObjectContext:workerContext];
            
            entry.original = attributesDict[@"original"];
            entry.imageURL = attributesDict[@"imageURL"];
            entry.author = attributesDict[@"author"];
            entry.published = attributesDict[@"published"];
            entry.identifier = attributesDict[@"identifier"];
            entry.title = attributesDict[@"title"];
            
            NSError *error;
            [workerContext save:&error];
        }
    });
}

@end
