//
//  WebView.m
//  OpenWebsite
//
//  Created by Shivashankaraiah, Shruti on 6/12/13.
//  Copyright (c) 2013 Shivashankaraiah, Shruti. All rights reserved.
//

#import "WebScreen.h"
#import "TableViewController.h"
#import "AppDelegate.h"

@interface WebScreen()

@end

@implementation WebScreen
{
    AppDelegate *appDelegate;
}
@synthesize url;
@synthesize localFilePath;
@synthesize localRequest;
@synthesize sortedKeys;
@synthesize webView;
@synthesize displayURL;
@synthesize downwardArrow;
@synthesize upwardArrow;
@synthesize localDisplayUrl;

- (void)viewDidLoad
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    downwardArrow.hidden=YES;
    upwardArrow.hidden=YES;
    //Loads Webview
    if([url length]==0)
    {
        [webView loadRequest:localRequest] ;
        displayURL.text=localDisplayUrl;
    }else{
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        [self placeTextViewOnScreen];
                NSLog(@"Length: %d ",[url length]);
    }
    
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //Enable scroll for webview.
    webView.scrollView.scrollEnabled = TRUE;
    //Fits web page to webview and enables zoom controls.
    webView.scalesPageToFit = YES;
    
    [super viewDidLoad];
    NSLog(@"Url is: %@",url);
    //[webView reload];
}
//Manages memory allocation for the views.
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if([self isViewLoaded] && self.view.window == nil)
    {
        self.view = nil;
    }
}

-(void)placeTextViewOnScreen{
    if([url length]<45){
        CGRect frame = displayURL.frame;
        frame.size.height = displayURL.contentSize.height;
        displayURL.frame = frame;
        displayURL.text=url;
    }else{
        if([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait){
            displayURL.text=[url substringToIndex:43];
        }else{
            displayURL.text=[url substringToIndex:63];
        }
        downwardArrow.hidden=NO;
        [downwardArrow addTarget:self action:@selector(expandTextView:) forControlEvents:UIControlEventTouchUpInside];
    }

}

-(BOOL)shouldAutorotate{
    return YES;
}
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self placeTextViewOnScreen];

}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}
- (IBAction)expandTextView:(id)sender {
    downwardArrow.hidden=YES;
    upwardArrow.hidden=NO;
    displayURL.text=url;
    CGRect frame = displayURL.frame;
    frame.size.height = displayURL.contentSize.height;
    displayURL.frame = frame;
    
    [upwardArrow addTarget:self action:@selector(contractTextView:) forControlEvents:UIControlEventTouchUpInside];
}
- (IBAction)contractTextView:(id)sender {
    upwardArrow.hidden=YES;
    if([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait){
    displayURL.text=[url substringToIndex:43];
    }else{
        displayURL.text=[url substringToIndex:63];
    }
    CGRect frame = displayURL.frame;
    frame.size.height = displayURL.contentSize.height;
    displayURL.frame = frame;
    
    downwardArrow.hidden=NO;
    [downwardArrow addTarget:self action:@selector(expandTextView:) forControlEvents:UIControlEventTouchUpInside];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}


@end