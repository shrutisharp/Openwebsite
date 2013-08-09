//
//  AppDelegate.m
//  OpenWebsite
//
//  Created by Shivashankaraiah, Shruti on 6/12/13.
//  Copyright (c) 2013 Shivashankaraiah, Shruti. All rights reserved.
//

#import "AppDelegate.h"
#import "TableViewController.h"
#import "WebScreen.h"
#import "VCAddCustomURL.h"

@implementation AppDelegate
@synthesize pearsonDefaults;
@synthesize defaults;
@synthesize sortedKeys;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self setupApp:application WithOptions:launchOptions];
    NSLog(@"Count %i",self.pearsonDefaults.count);
        
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//-------------------------------------------------------------------------------------

- (void)setupApp:(UIApplication *)application WithOptions:(NSDictionary *)launchOptions
{
    //holds sorted keys
    sortedKeys=[[NSMutableArray alloc]init];

    for (NSString *key in sortedKeys) {
        NSLog(@"Sorted Keys in app delegate: key: %@ ",key);
    }
    
    // read in the "DefaultSites.plist" file and setup the array
    NSString *filePath=[[NSBundle mainBundle] pathForResource:@"PearsonDefaults" ofType:@"plist"];
    NSLog(@"filepath: %@",filePath);
    self.pearsonDefaults=[NSDictionary dictionaryWithContentsOfFile:filePath];
    
    //for saving custom urls in NSUserDefaults
    defaults=[NSUserDefaults standardUserDefaults];
    
}

@end
