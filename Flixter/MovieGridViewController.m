//
//  MovieGridViewController.m
//  Flixter
//
//  Created by Yonatan Desta on 6/17/22.
//

#import "MovieGridViewController.h"
#import "MovieCell.h"
#import "UIImageview+AFNetworking.h"


@interface MovieGridViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *movieArray;


@end

@implementation MovieGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=e2223325a99d5298b9d6d2d2de395337"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               NSLog(@"%@", dataDictionary);
               
               // TODO: Get the array of movies
               self.movieArray = dataDictionary[@"results"];
               
               for (NSDictionary *movieArray in self.movieArray){
                   
                   NSLog(@"%@", movieArray[@"title"]);
               }
               
               // reloads the table view data
               [self.collectionView reloadData];
               
               
               
           }
       }];
    [task resume];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // reuses the single template of a arbitrary movie collection cell with unique identifier
    
    MovieCell *movieCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieImageCell" forIndexPath:indexPath];
    NSDictionary *movie = self.movieArray[indexPath.row];

    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = movie[@"poster_path"];
    NSString *completePosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:completePosterURLString];
    
    [movieCell.movieImage setImageWithURL:posterURL];

    return movieCell;

}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movieArray.count;
}


@end
