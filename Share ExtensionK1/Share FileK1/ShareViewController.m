//
//  ShareViewController.m
//  Share FileK1
//
//  Created by Kishore on 25/10/18.
//  Copyright © 2018 Kishore. All rights reserved.
//

#import "ShareViewController.h"
#import "GroupInfo.h"              //Importing GroupInfo header

@interface ShareViewController ()
{
    NSArray *dataarray;
    NSArray *urlarray;
    NSMutableArray *arrayofmutabledata;
    NSMutableArray *arrayofmutableurl;
    
}
@property GroupInfo *groupinfo;    //Here Extending class oF groupinfo creating a instance variable

@end

@implementation ShareViewController
@synthesize groupinfo;              //Synthesize groupinfo means creating a object of GroupInfo

- (BOOL)isContentValid {
    // Do validation of contentText and/or NSExtensionContext attachments here
    return YES;
}


- (void)didSelectPost
{
    
    dataarray = [[NSArray alloc] init];
    urlarray = [[NSArray alloc] init];
    arrayofmutabledata = [[NSMutableArray alloc] init];
    arrayofmutableurl = [[NSMutableArray alloc] init];
    
    for (NSItemProvider* itemProvider in ((NSExtensionItem*)self.extensionContext.inputItems[0]).attachments ) {
    if([itemProvider hasItemConformingToTypeIdentifier:(__bridge NSString *)kUTTypeContent]|| [itemProvider hasItemConformingToTypeIdentifier:(__bridge NSString *)kUTTypeMPEG4Audio] || [itemProvider hasItemConformingToTypeIdentifier:(__bridge NSString *)kUTTypeHTML]) {
        NSLog(@"item provider %@",itemProvider);
        
        NSString *identifier;

        if([itemProvider hasItemConformingToTypeIdentifier:(__bridge NSString *)kUTTypeContent] ){
            identifier =(__bridge NSString *)kUTTypeContent;
        }
        else if([itemProvider hasItemConformingToTypeIdentifier:(__bridge NSString *)kUTTypeMPEG4Audio] ){
            identifier =(__bridge NSString *)kUTTypeMPEG4Audio;
        }
        else if ([itemProvider hasItemConformingToTypeIdentifier:(__bridge NSString *)kUTTypeHTML] ){
            identifier =(__bridge NSString *)kUTTypeHTML;
        }
        
        else if ([itemProvider hasItemConformingToTypeIdentifier:(__bridge NSString *)kUTTypeBzip2Archive]){
            identifier =(__bridge NSString *)kUTTypeBzip2Archive;
        }
        
        
        [itemProvider loadItemForTypeIdentifier:identifier options:nil completionHandler:
         ^(NSURL *itemUrl, NSError *error) {
             
             NSLog(@"itemUrl path: %@", itemUrl);
             NSData *data = [NSData dataWithContentsOfURL:itemUrl];
             NSData *data1 = [NSData dataWithContentsOfFile:itemUrl];
             NSLog(@"data length is %lu",data.length);
             NSLog(@"ContentsOF fiLE %@",data1);
             NSLog(@"The Split data is %lu",(data.length/2));
             
             [self->arrayofmutabledata addObject:data];
             [self->arrayofmutableurl addObject:[itemUrl path]];
             self->dataarray = [self->arrayofmutabledata copy];
             self->urlarray = [self->arrayofmutableurl copy];
             
             NSLog(@"audioarray is %@",self->arrayofmutabledata);
             NSLog(@"audiofilearray is %@",self->arrayofmutableurl);
             
             NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
             dict[@"data"] = self->dataarray;
             dict[@"audioOrPdfOrDoc"] = self->urlarray;
             NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.k4.DemoDocExtension"];
             [defaults setObject:dict forKey:@"audio"];
             [defaults synchronize];
             
             
         }];

    }
    }

//    [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
}

- (NSArray *)configurationItems {
    return @[];
}


@end
