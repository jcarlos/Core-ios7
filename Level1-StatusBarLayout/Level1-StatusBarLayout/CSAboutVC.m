#import "CSAboutVC.h"

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
    
    // TODO: Implement contentSubview and add these subviews to contentSubview instead of view
    self.contentSubview = [[UIView alloc] init];
    
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
    
    self.csLogoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CSLogo"]];
    
    [self.contentSubview addSubview:self.csLogoImageView];
    
    self.descriptionTextView = [[UITextView alloc] init];
    self.descriptionTextView.font = [UIFont fontWithName:@"HelveticaNeue" size:15.0f];
    self.descriptionTextView.backgroundColor = [UIColor clearColor];
    self.descriptionTextView.textColor = [UIColor whiteColor];
    self.descriptionTextView.editable = NO;
    
    [self.contentSubview addSubview:self.descriptionTextView];
    
    [view addSubview: self.contentSubview];
    // TODO: Don't forget to add self.contentSubview as a subview of view
    
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
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    // TODO: Uncomment the line below and set the frame of self.contentSubview using the topLayoutGuide
    self.contentSubview.frame = CGRectMake(0, self.topLayoutGuide.length, CGRectGetWidth(self.view.frame), (CGRectGetHeight(self.view.frame) - self.topLayoutGuide.length));
    
    self.headerLabel.frame = CGRectMake(20,
                                        5,
                                        280,
                                        self.headerLabel.font.pointSize + 5);
    
    self.authorLabel.frame = CGRectMake(30,
                                        CGRectGetMaxY(self.headerLabel.frame) + kViewPadding + 5,
                                        100,
                                        self.authorLabel.font.pointSize);
    
    self.csLogoImageView.frame = CGRectMake(140,
                                            CGRectGetMaxY(self.headerLabel.frame) + kViewPadding,
                                            self.csLogoImageView.image.size.width,
                                            self.csLogoImageView.image.size.height);
    
    self.descriptionTextView.frame = CGRectMake(20,
                                                CGRectGetMaxY(self.csLogoImageView.frame) + kViewPadding,
                                                280,
                                                176);
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
