//
//  AddCustomURL.h
//  OpenWebsite
//
//  Created by Shivashankaraiah, Shruti on 6/12/13.
//  Copyright (c) 2013 Shivashankaraiah, Shruti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewController.h"


@interface VCAddCustomURL : UIViewController<UITextFieldDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong, nonatomic) IBOutlet UITextField *txtUrl;
@property(weak,nonatomic) IBOutlet UITextField *desc;
@property (weak, nonatomic) IBOutlet UIButton *save;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic) NSInteger disclosureFlag;
@property (nonatomic) NSInteger dictionaryRow;

- (IBAction)returnFromKeypad:(id)sender;
- (IBAction)backgroundClicked:(id)sender;
- (IBAction)save:(id)sender;
-(IBAction)deleteAction:(id)sender;
-(void)prepopulateTextFields;
-(BOOL)checkForDuplicateKeyCompareWithNewKey:(NSString*)newKey;
@end