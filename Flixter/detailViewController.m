//
//  detailViewController.m
//  Flixter
//
//  Created by Yonatan Desta on 6/17/22.
//

#import "detailViewController.h"
#import "UIImageview+AFNetworking.h"


@interface detailViewController () 
@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
@property (weak, nonatomic) IBOutlet UILabel *movieDescription;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;

@end

@implementation detailViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    self.movieTitle.text = self.detailDict[@"title"];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = self.detailDict[@"poster_path"];
    NSString *completePosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:completePosterURLString];
    [self.movieImage setImageWithURL:posterURL];
    
    self.movieDescription.text = self.detailDict[@"overview"];
    
    
    
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
