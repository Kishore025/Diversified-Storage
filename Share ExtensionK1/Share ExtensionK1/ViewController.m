//
//  ViewController.m
//  Share ExtensionK1
//
//  Created by Kishore on 25/10/18.
//  Copyright © 2018 Kishore. All rights reserved.
//

#import "ViewController.h"
#import "GroupInfo.h" // Not Required Now

@interface ViewController ()



@property GroupInfo *groupInfo;//Not Required Now
@end

@implementation ViewController
@synthesize groupInfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults * defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.k4.DemoDocExtension"];
    NSMutableDictionary *dict = [defaults valueForKey:@"audio"];
    
    if(dict)
    {
        NSArray *audiodata = [dict valueForKey:@"data"];
        NSLog(@"audiofilelenght is %lu",(unsigned long)[audiodata count]);
        NSArray *audioUrl = [dict valueForKey:@"audioOrPdfOrDoc"];
        NSLog(@"audiofilelenght is %@",audioUrl);
        [defaults removeObjectForKey:@"audio"];
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
@end
