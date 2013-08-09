//
//  AddCustomURL.m
//  OpenWebsite
//
//  Created by Shivashankaraiah, Shruti on 6/12/13.
//  Copyright (c) 2013 Shivashankaraiah, Shruti. All rights reserved.
//

#import "TableViewController.h"
#import "VCAddCustomURL.h"
#import "AppDelegate.h"

@interface VCAddCustomURL ()

@end

@implementation VCAddCustomURL
{
    NSString *url;
    NSString *localFileName;
    NSString *fetchedUrl;
    NSString *fetchedDesc;
    AppDelegate *appDelegate;

}
@synthesize deleteButton;
@synthesize txtUrl;
@synthesize save;
@synthesize desc;
@synthesize disclosureFlag;
@synthesize dictionaryRow;
@synthesize scrollView;

-(void)viewDidLoad{
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    deleteButton.hidden=YES;
    if(disclosureFlag==1){
        deleteButton.hidden=NO;
        [self prepopulateTextFields];
    }
    
}

//for dismissing keypad for the text field
- (IBAction)returnFromKeypad:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)backgroundClicked:(id)sender{
    [txtUrl resignFirstResponder];
    [desc resignFirstResponder];
}

- (IBAction)save:(id)sender{
    //Url or Description cannot be empty
    if([txtUrl.text length]>0 && [desc.text length]>0){
        //if there is no key with the same name as new key entered and disclosure button is clicked
        if(![self checkForDuplicateKeyCompareWithNewKey:desc.text]&&disclosureFlag==1){
            NSLog(@"Condition 1");
                //if both url and desc are changed
            if((!([txtUrl.text isEqualToString:fetchedUrl]) && !([desc.text isEqualToString:fetchedDesc]))||(!([desc.text isEqualToString:fetchedDesc]))){
                    [appDelegate.defaults removeObjectForKey:[appDelegate.sortedKeys objectAtIndex:dictionaryRow]];
                    [appDelegate.sortedKeys removeObjectAtIndex:dictionaryRow];
                }
                //When there is no duplicate add the url and Desc to the dictionary
                [appDelegate.sortedKeys addObject:desc.text];
                [appDelegate.defaults setObject:txtUrl.text forKey:desc.text];
            //navigates to RootViewController.
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else if(![self checkForDuplicateKeyCompareWithNewKey:desc.text]&&disclosureFlag==0){
            NSLog(@"Condition 2");
                //When there is no duplicate add the url and Desc to the dictionary
                [appDelegate.sortedKeys addObject:desc.text];
                [appDelegate.defaults setObject:txtUrl.text forKey:desc.text];
                for(NSString *key in appDelegate.sortedKeys){
                    NSLog(@"while sending from custom scree: key: and value %@ and %@",key, [appDelegate.defaults objectForKey:key]);
                }
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else if([self checkForDuplicateKeyCompareWithNewKey:desc.text]&&disclosureFlag==1){
            NSLog(@"Condition 3");
            if(([txtUrl.text isEqualToString:fetchedUrl]) && ([desc.text isEqualToString:fetchedDesc])){
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else if(!([txtUrl.text isEqualToString:fetchedUrl]) && ([desc.text isEqualToString:fetchedDesc])){
                [appDelegate.defaults setObject:txtUrl.text forKey:desc.text];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"This Description already exists. Do you want to overwrite?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil];
                    [alert show];
        }

        }else {
            NSLog(@"Condition 4");
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"This Description already exists. Use a different one!" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
                [alert addButtonWithTitle:@"Ok"];
                [alert show];
        }
    }else{
        NSLog(@"Condition 5");
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Url or Description cannot be empty" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        [alert addButtonWithTitle:@"Ok"];
        [alert show];
    }
}

//Method compares the clicked row's key with new key and returns a bool value
-(BOOL)checkForDuplicateKeyCompareWithNewKey:(NSString*)newKey{
    // values in foreach loop
    NSInteger keyDuplicate=0;
    //check if the key is already present in the dictionary
    for (NSString *key in appDelegate.sortedKeys) {
        NSLog(@"  Comparing \"%@\" and \"%@\"",key,newKey);
        if([key isEqualToString:newKey])
            keyDuplicate++;
    }
    NSLog(@"Duplicates: %d",keyDuplicate);
    if(keyDuplicate>0)
        return YES;
    return NO;
}

//Method prepopulates existing information for editing
-(void)prepopulateTextFields{
    fetchedUrl=[appDelegate.defaults objectForKey:[appDelegate.sortedKeys objectAtIndex:dictionaryRow]];
    txtUrl.text=fetchedUrl;
    fetchedDesc=[appDelegate.sortedKeys objectAtIndex:dictionaryRow];
    desc.text=fetchedDesc;
}

- (IBAction)deleteAction:(id)sender {
    [appDelegate.defaults removeObjectForKey:[appDelegate.sortedKeys objectAtIndex:dictionaryRow]];
    [appDelegate.sortedKeys removeObjectAtIndex:dictionaryRow];
    [self.navigationController popToRootViewControllerAnimated:YES ];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Yes"])
    {
        NSLog(@"Yes was selected.");
        [appDelegate.defaults removeObjectForKey:fetchedDesc];
        [appDelegate.sortedKeys removeObjectIdenticalTo:desc.text];
        [appDelegate.defaults setObject:txtUrl.text forKey:desc.text];
        [appDelegate.sortedKeys addObject:desc.text];

        //Navigate to RootViewController
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else if([title isEqualToString:@"No"])
    {
        [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
        NSLog(@"No was selected.");
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if([self isViewLoaded] && self.view.window == nil)
    {
        self.view = nil;
    }
}
-(BOOL)shouldAutorotate{
    return YES;
}
-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (IBAction)button1:(id)sender {
    desc.text=@"Google";
    txtUrl.text=@"http://www.google.com";

}
- (IBAction)button2:(id)sender {
    desc.text=@"Infosys";
    txtUrl.text=@"http://www.infosys.com";

}
- (IBAction)button3:(id)sender {
    desc.text=@"Wix";
    txtUrl.text=@"http://www.wix.com";

}
- (IBAction)button4:(id)sender {
    desc.text=@"ASU";
    txtUrl.text=@"http://www.asu.com";

}
- (IBAction)button5:(id)sender {
    desc.text=@"Pearson";
    txtUrl.text=@"http://www.pearson.com";

}
- (IBAction)button6:(id)sender {
    desc.text=@"Yahoo";
    txtUrl.text=@"http://www.yahoo.com";

}
- (IBAction)button7:(id)sender {
    desc.text=@"Times of India";
    txtUrl.text=@"http://www.timesofindia.com";

}
- (IBAction)button8:(id)sender {
    desc.text=@"Mashable";
    txtUrl.text=@"http://www.mashable.com";

}
- (IBAction)button9:(id)sender {
    desc.text=@"Amazon";
    txtUrl.text=@"http://www.amazon.com";

}
- (IBAction)button10:(id)sender {
    desc.text=@"Ebay";
    txtUrl.text=@"http://stackoverflow.com/questions/11387467/uiwebview-landscape-rotation-does-not-fill-view";

}














@end