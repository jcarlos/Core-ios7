#import "UserViewController.h"
#import "UserInfo.h"

@interface UserViewController ()
@property (strong, nonatomic) NSDictionary *userInfo;
@property (strong, nonatomic) NSArray *levels;
@end

@implementation UserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _levels = [NSArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Fetch the user's info from the server
    [UserInfo getUserInfo:^(NSDictionary *userInfo) {
        _userInfo = userInfo;
        _levels = _userInfo[@"levels"];
        
        // Make sure to call setupViews on the main thread
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self setupViews];
        }];
    }];
}

- (void)setupViews
{
    if (_userInfo) {
        if (_userInfo[@"name"] != [NSNull null]) {
            self.userLabel.text = [NSString stringWithFormat:@"%@'s progress (%@ pts)", _userInfo[@"name"], _userInfo[@"points"]];
        }else{
            self.userLabel.text = [NSString stringWithFormat:@"Player #%@'s progress (%@ pts)", _userInfo[@"id"], _userInfo[@"points"]];
        }
        
        // Set the progress through the entire course
        self.progress.progress = ([_userInfo[@"progress"] floatValue] / 100);
        
        // Reloads the table
        [self.levelsView reloadData];
    }
}

#pragma mark - UITableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _levels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *level = _levels[indexPath.row];
    NSNumber *progress = level[@"progress"];
    
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:16.0];
    
    UIView *progressView = [[UIView alloc] init];
    progressView.backgroundColor = [UIColor colorWithRed:0.0f green:0.49f blue:0.96f alpha:1.0f];;
    progressView.alpha = 0.5;
    progressView.frame = CGRectMake(0, 0, CGRectGetWidth(cell.contentView.frame) * ([progress floatValue] / 100), CGRectGetHeight(cell.contentView.frame));
    [cell.contentView insertSubview:progressView atIndex:0];
    
    cell.textLabel.text = level[@"name"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%% complete", progress];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
