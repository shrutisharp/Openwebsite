//
//  WebView.h
//  OpenWebsite
//
//  Created by Shivashankaraiah, Shruti on 6/12/13.
//  Copyright (c) 2013 Shivashankaraiah, Shruti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebScreen : UIViewController<UIAlertViewDelegate>
@property (retain,nonatomic) IBOutlet UIWebView *webView;
//url obtained from first screen
@property (weak, nonatomic) IBOutlet UITextView *displayURL;
@property (weak, nonatomic) IBOutlet UIButton *downwardArrow;
@property (weak, nonatomic) IBOutlet UIButton *upwardArrow;
@property (retain,nonatomic) NSString *url;
@property (retain,nonatomic) NSString *localFilePath;
@property (retain,nonatomic) NSURLRequest *localRequest;
@property (nonatomic,retain) NSMutableArray *sortedKeys;
@property (retain,nonatomic) NSString *localDisplayUrl;

-(void)placeTextViewOnScreen;
- (IBAction)expandTextView:(id)sender;
- (IBAction)contractTextView:(id)sender;
//- (IBAction)back:(id)sender;

@end