#import "CSPhotoDetailVC.h"

#import "Photo.h"

#import "CSEditPhotoNote.h"

@implementation CSPhotoDetailVC

- (id)init
{
    self = [super init];
    if(self) {
        self.title = [NSString stringWithFormat:@"Photo ID %ld",(long)self.photo.photoId];
        
        UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                    target:self
                                                                                    action:@selector(editButtonTapped:)];
        self.navigationItem.rightBarButtonItem = editButton;
    }
    return self;
}

- (void)loadView
{
    self.scrollView = [[UIScrollView alloc] init];
    
    self.photoImageView = [[UIImageView alloc] init];
    [self.scrollView addSubview:self.photoImageView];

    self.photoNameLabel = [[UILabel alloc] init];
    self.photoNameLabel.backgroundColor = [UIColor clearColor];
    self.photoNameLabel.textAlignment = NSTextAlignmentRight;
    self.photoNameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0f];
    self.photoNameLabel.textColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.photoNameLabel];
    
    self.notesView = [[UITextView alloc] init];
    self.notesView.editable = NO;
    self.notesView.font = [UIFont fontWithName:@"HelveticaNeue" size:22.0f];
    [self.scrollView addSubview:self.notesView];
    
    self.view = self.scrollView;
}

- (void)viewDidLoad
{
    self.photoImageView.image = [self.photo loadImage:self.photo.filename];
    
    self.photoNameLabel.text = self.photo.name;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.notesView.text = self.photo.notes;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.photoImageView.frame = CGRectMake(0,
                                           0,
                                           CGRectGetWidth(self.scrollView.frame),
                                           200);
    
    self.photoNameLabel.frame = CGRectMake(20,
                                      CGRectGetMaxY(self.photoImageView.frame) - 40,
                                      280,
                                      40);
    
    self.notesView.frame = CGRectMake(10,
                                      CGRectGetMaxY(self.photoImageView.frame) + 10,
                                      CGRectGetWidth(self.scrollView.frame) - 10,
                                      140);
}

- (void)editButtonTapped:(id)sender
{
    CSEditPhotoNote *csEditPhotoNote = [[CSEditPhotoNote alloc] init];
    csEditPhotoNote.photo = self.photo;

    [self.navigationItem setBackBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:self.photo.name
                                                                               style:UIBarButtonItemStyleBordered
                                                                              target:nil
                                                                              action:nil]];
    [self.navigationController pushViewController:csEditPhotoNote animated:YES];
}

@end
