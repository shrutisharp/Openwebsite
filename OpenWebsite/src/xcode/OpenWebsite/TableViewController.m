#import "TableViewController.h"
#import "VCAddCustomURL.h"
#import "AppDelegate.h"
#import "WebScreen.h"
#import <QuartzCore/QuartzCore.h>

@interface TableViewController ()

@end

@implementation TableViewController
{
    NSString *url;
    NSString *localFileName;
    NSInteger *section2Rows;
    AppDelegate *appDelegate;
}

@synthesize tblView;
@synthesize disclosureFlag;
@synthesize dictionaryRow;
@synthesize delegate;

-(void)viewDidLoad{
    
    [super viewDidLoad];
    // If Disclosure button is clicked then flag is 1 else 0. In the AddCustomURL screen, prepopulates the respective fields for editing. 
    disclosureFlag=0;
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    tblView.scrollEnabled=YES;
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSDateComponents * components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSSecondCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit
                                                fromDate:[NSDate date]];
    NSString * stringDate = [NSString stringWithFormat:@"%d-%d-%d %d:%d:%d", components.year, components.month, components.day, components.hour, components.minute, components.second];
    NSLog(@"Start screen view loaded %@",stringDate);
    //print defaults:
    for(NSString *key in appDelegate.sortedKeys){
        NSLog(@"--------key: and value %@ and %@",key, [appDelegate.defaults objectForKey:key]);
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    //Arrange alphabetically.
    NSArray *alpabeticallySortedKeys=[[NSArray alloc]init];
    if(!alpabeticallySortedKeys){
        alpabeticallySortedKeys = [[NSArray alloc]init];
    }
    alpabeticallySortedKeys=appDelegate.sortedKeys;
    
    appDelegate.sortedKeys = [NSMutableArray arrayWithArray:[alpabeticallySortedKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]];
    [tblView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        NSArray *keys=[appDelegate.pearsonDefaults allKeys];
        NSArray *data = [appDelegate.pearsonDefaults objectForKey:[keys objectAtIndex:0]];
        NSInteger rowsReturned=data.count;
        return  rowsReturned;
    }else if (section==1){
        NSInteger rowsReturned;
        NSInteger savedUrlsCount=0;
        for (NSString *key in appDelegate.sortedKeys){
            savedUrlsCount++;
        }
        rowsReturned= savedUrlsCount+1;
        NSLog(@"... (a) no. of rows in section 2 is: %d (dictionary has %d)",rowsReturned,savedUrlsCount);
        return rowsReturned;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tblView dequeueReusableCellWithIdentifier:@"Maincell"];

    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Maincell"];
    }
 
    NSInteger savedUrlsCount=[appDelegate.sortedKeys count];
    
    if(indexPath.section==0) {
        NSArray *keys=[appDelegate.pearsonDefaults allKeys];
        NSArray *data = [appDelegate.pearsonDefaults objectForKey:[keys objectAtIndex:0]];
        NSMutableDictionary *details=[data objectAtIndex:indexPath.row];
        cell.textLabel.text=[details objectForKey:@"Site Name"];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }else if(indexPath.section==1 && indexPath.row==(savedUrlsCount)){
        UITableViewCell *ccell=[tblView dequeueReusableCellWithIdentifier:@"CustomWebsite"];
        if(ccell==nil)
        {
            ccell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomWebsite"];
        }
        ccell.textLabel.text=@"Add Custom Website";
        ccell.userInteractionEnabled = YES;
        ccell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;

        NSLog(@"came to custom website (%@)",[indexPath debugDescription]);
        ccell.textLabel.textColor=[UIColor blueColor];
        ccell.textLabel.font = [UIFont systemFontOfSize:18];
        
        return ccell;
    }else {
        NSLog(@"indexpath: %d, dict  count %d",indexPath.row,savedUrlsCount);
        //print dictionary
        for (NSString *key in appDelegate.sortedKeys) {
            NSLog(@"From startscreen Dict: key: %@ ",key);
        }
        if(savedUrlsCount>0){
            cell.textLabel.text=[appDelegate.sortedKeys objectAtIndex:indexPath.row];
        }
        cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:18];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSInteger savedUrlsCount=[appDelegate.sortedKeys count];
    
   if(indexPath.section==0) {
       //For reading from plist
       NSArray *keys=[appDelegate.pearsonDefaults allKeys];
       NSArray *data = [appDelegate.pearsonDefaults objectForKey:[keys objectAtIndex:0]];
       NSMutableDictionary *details=[data objectAtIndex:indexPath.row];
       localFileName=[details objectForKey:@"Site URL"];
       NSLog(@"here if");
       NSString *localFilePath = [[NSBundle mainBundle] pathForResource:localFileName ofType:@"html"] ;
       NSURLRequest *localRequest = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:localFilePath]] ;
       NSLog(@"1");
       WebScreen *ws=[self.storyboard instantiateViewControllerWithIdentifier:@"WebView"];
       NSLog(@"2 ");
       ws.localDisplayUrl=[details objectForKey:@"Site Name"];
       ws.localFilePath=localFilePath;
       ws.localRequest=localRequest;
       NSLog(@"sending from tvc: %@, %@",localFilePath,localRequest);
       
       [self.navigationController pushViewController:ws animated:YES];
   }else if(indexPath.section==1 && indexPath.row==(savedUrlsCount)){
       VCAddCustomURL *cUrl=[self.storyboard instantiateViewControllerWithIdentifier:@"AddCustomURL"];
       [self.navigationController pushViewController:cUrl animated:YES];
   }else{
       WebScreen *ws=[self.storyboard instantiateViewControllerWithIdentifier:@"WebView"];
       if(savedUrlsCount>0){
           NSString *currentKey=[appDelegate.sortedKeys objectAtIndex:indexPath.row];
           ws.url=[appDelegate.defaults objectForKey:currentKey];
       }
       [self.navigationController pushViewController:ws animated:YES ];
   }

}

-(void)tableView:(UITableView*)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==1){
        VCAddCustomURL *cUrl=[self.storyboard instantiateViewControllerWithIdentifier:@"AddCustomURL"];
        if(indexPath.row==[appDelegate.sortedKeys count]){
            disclosureFlag=0;
        }else{
            disclosureFlag=1;
        }

        cUrl.dictionaryRow=indexPath.row;
        cUrl.disclosureFlag=disclosureFlag;
        [self.navigationController pushViewController:cUrl animated:YES];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = NSLocalizedString(@"Pearson Defaults", @"Pearson Defaults");
            break;
        case 1:
            sectionName = NSLocalizedString(@"Custom Websites", @"Custom Websites");
            break;
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}

-(BOOL)shouldAutorotate{
    return YES;
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];    
    [self.tblView reloadData];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if([self isViewLoaded] && self.view.window == nil)
    {
        self.view = nil;
    }
}

@end
