//
//  AppDelegate.h
//  OpenWebsite
//
//  Created by Shivashankaraiah, Shruti on 6/12/13.
//  Copyright (c) 2013 Shivashankaraiah, Shruti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSDictionary *pearsonDefaults;
@property (strong,nonatomic) NSUserDefaults *defaults;
@property (strong, nonatomic) NSMutableArray *sortedKeys;

- (void)setupApp:(UIApplication *)application WithOptions:(NSDictionary *)launchOptions;

@end
