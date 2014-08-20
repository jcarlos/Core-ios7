#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "CSEditPhotoNote.h"

@class Photo;

@interface CSPhotoDetailVC : UIViewController <MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) Photo *photo;
@property (strong, nonatomic) UILabel *photoNameLabel;

@property (strong, nonatomic) UIScrollView *scrollView;

// We added a UIToolbar in this challenge - nothing to do here, we're just letting you know so you don't miss it!
@property (strong, nonatomic) UIToolbar *functionBar;

@property (strong, nonatomic) UIImageView *photoImageView;
@property (strong, nonatomic) UITextView *notesView;

@end