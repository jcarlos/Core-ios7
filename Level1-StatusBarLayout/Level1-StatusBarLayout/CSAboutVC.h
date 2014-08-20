#import <UIKit/UIKit.h>

@interface CSAboutVC : UIViewController

// TODO: Declare a UIView property named contentSubview here

@property (strong, nonatomic) UILabel *headerLabel;
@property (strong, nonatomic) UILabel *authorLabel;
@property (strong, nonatomic) UIImageView *csLogoImageView;
@property (strong, nonatomic) UITextView *descriptionTextView;
@property (strong, nonatomic) UIView *contentSubview;

@end
