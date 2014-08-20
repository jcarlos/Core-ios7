#import <UIKit/UIKit.h>
#import "CSEditPhotoNote.h"

@class Photo;

@interface CSPhotoDetailVC : UIViewController

@property (strong, nonatomic) Photo *photo;
@property (strong, nonatomic) UILabel *photoNameLabel;

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIImageView *photoImageView;
@property (strong, nonatomic) UITextView *notesView;

@end