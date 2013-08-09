#import <UIKit/UIKit.h>
#import "WebScreen.h"
#import "VCAddCustomURL.h"

@interface TableViewController : UITableViewController<UITextFieldDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,retain) IBOutlet UITableView *tblView;
@property (nonatomic) NSInteger disclosureFlag;
@property (nonatomic) NSInteger dictionaryRow;
@property (nonatomic) id delegate;

@end
