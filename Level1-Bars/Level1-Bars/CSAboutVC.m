#import "CSAboutVC.h"

#import "CSWebVC.h"

#define kViewPadding 25.0f

@interface CSAboutVC ()

@end

@implementation CSAboutVC

- (id)init
{
    self = [super init];
    if(self) {
        self.title = @"About This App";
        self.tabBarItem.image = [UIImage imageNamed:@"CS-tabBar"];
    }
    return self;
}

- (void)loadView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:0.40 green:0.71 blue:0.9 alpha:1.0];
    
    self.contentSubview = [[UIScrollView alloc] init];
    
    self.headerLabel = [[UILabel alloc] init];
    self.authorLabel = [[UILabel alloc] init];
    
    self.headerLabel.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:40.0f];
    self.headerLabel.backgroundColor = [UIColor clearColor];
    self.headerLabel.textColor = [UIColor whiteColor];
    
    self.authorLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20.0f];
    self.authorLabel.backgroundColor = [UIColor clearColor];
    self.authorLabel.textColor = [UIColor whiteColor];
    
    [self.contentSubview addSubview:self.headerLabel];
    [self.contentSubview addSubview:self.authorLabel];
    
    // We added this custom image button that calls logoTapped: which then displays codeschool.com in CSWebVC
    self.csLogoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.csLogoButton setImage:[UIImage imageNamed:@"CSLogo"] forState:UIControlStateNormal];
    [self.csLogoButton addTarget:self action:@selector(logoTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentSubview addSubview:self.csLogoButton];
    
    self.descriptionTextView = [[UITextView alloc] init];
    self.descriptionTextView.font = [UIFont fontWithName:@"HelveticaNeue" size:15.0f];
    self.descriptionTextView.backgroundColor = [UIColor clearColor];
    self.descriptionTextView.textColor = [UIColor whiteColor];
    self.descriptionTextView.editable = NO;
    [self.contentSubview addSubview:self.descriptionTextView];
    
    // We also added another UITextView, and now the text is running past the available window size.  That's why we're turning self.contentSubview into a UIScrollView - so we can scroll to see all of the text
    self.csInfoTextView = [[UITextView alloc] init];
    self.csInfoTextView.font = [UIFont fontWithName:@"HelveticaNeue" size:15.0f];
    self.csInfoTextView.backgroundColor = [UIColor clearColor];
    self.csInfoTextView.textColor = [UIColor whiteColor];
    self.csInfoTextView.editable = NO;
    [self.contentSubview addSubview:self.csInfoTextView];
    
    [view addSubview:self.contentSubview];
    
    self.view = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSShadow *textShadow = [[NSShadow alloc] init];
    textShadow.shadowOffset = CGSizeMake(2, 2);
    textShadow.shadowBlurRadius = 4.0;
    
    NSAttributedString *headerText = [[NSAttributedString alloc] initWithString:@"PhotoNotes" attributes:@{NSShadowAttributeName: textShadow}];
    self.headerLabel.attributedText = headerText;
    
    self.authorLabel.text = @"Created by";
    self.descriptionTextView.text = @"PhotoNotes is a simple app created for Code School's Core iOS 7 course.  If you install this app on your phone then you will be able to take photos and add some notes about them.  For example, you might take a picture of a tree and leave a note about why you found that tree worthy of capturing.";
    
    self.csInfoTextView.text = @"Code School teaches web and app development technologies in the comfort of your browser with video lessons, coding challenges, and screencasts.  With the release of iOS 7, we're now expanding our code challenges to the environment that most iOS developers work in - Xcode.  By completing challenges in Xcode and still earning points and badges on codeschool.com, we're able to bring you the best of both worlds so you can start building apps quickly. We strive to help you learn by doing.";
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    // TODO: Now that contentSubview is a UIScrollView, we need to fix the way we're setting the frame because it is interfering with self.automaticallyAdjustsScrollViewInsets
    
    self.contentSubview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.contentSubview.contentOffset = CGPointMake(0, -64);
    self.contentSubview.frame = CGRectMake(0, 0,
                                           CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)
                                           );
/*
    self.contentSubview.frame = CGRectMake(0,
                                           self.topLayoutGuide.length,
                                           CGRectGetWidth(self.view.frame),
                                           CGRectGetHeight(self.view.frame) - self.topLayoutGuide.length);
  */
    self.headerLabel.frame = CGRectMake(20,
                                        5,
                                        280,
                                        self.headerLabel.font.pointSize + 5);
    
    self.authorLabel.frame = CGRectMake(30,
                                        CGRectGetMaxY(self.headerLabel.frame) + kViewPadding + 5,
                                        100,
                                        self.authorLabel.font.pointSize);
    
    self.csLogoButton.frame = CGRectMake(140,
                                            CGRectGetMaxY(self.headerLabel.frame) + kViewPadding,
                                            self.csLogoButton.imageView.image.size.width,
                                            self.csLogoButton.imageView.image.size.height);
    
    self.descriptionTextView.frame = CGRectMake(20,
                                                CGRectGetMaxY(self.csLogoButton.frame) + kViewPadding,
                                                280,
                                                160);

    self.csInfoTextView.frame = CGRectMake(20,
                                           CGRectGetMaxY(self.descriptionTextView.frame) + kViewPadding,
                                           280,
                                           300);
    
    // TODO: Use CGSizeMake to set the contentSize property of contentSubview.  Set the width to the full width of self.view, and set the height based on the max Y position of self.csInfoTextView (using the CGRectGetMaxY() function is the quick way to get the maxY value).  Then, add kViewPadding to the height so we've got a little bit of padding between the text view and the tab bar at the bottom of the screen.
    self.contentSubview.contentSize = CGSizeMake(CGRectGetWidth(self.contentSubview.frame), CGRectGetMaxY(self.csInfoTextView.frame) + kViewPadding);
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)logoTapped:(id)sender
{
    CSWebVC *csWebVC = [[CSWebVC alloc] init];
    [self.navigationController pushViewController:csWebVC animated:YES];
}

@end
