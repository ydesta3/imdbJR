//
//  detailViewController.m
//  Flixter
//
//  Created by Yonatan Desta on 6/17/22.
//

#import "MovieDetailsViewController.h"
#import "UIImageview+AFNetworking.h"


@interface MovieDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation MovieDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    self.titleLabel.text = self.detailDict[@"title"];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = self.detailDict[@"poster_path"];
    NSString *completePosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:completePosterURLString];
    [self.imageView setImageWithURL:posterURL];
    
    self.descriptionLabel.text = self.detailDict[@"overview"];
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
