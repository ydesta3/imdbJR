//
//  MovieViewController.m
//  Flixter
//
//  Created by Yonatan Desta on 6/15/22.
//

#import "MovieViewController.h"
#import "singleMovieCell.h"
#import "UIImageview+AFNetworking.h"
#import "detailViewController.h"



@interface MovieViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) NSArray *movieArray;

@end

//NSArray *data;

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.activityIndicator startAnimating];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.activityIndicator stopAnimating];
    
    
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
               [self.tableView reloadData];
               
               
           }
       }];
    [task resume];
    
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *index = self.tableView.indexPathForSelectedRow;
    
    NSDictionary *dataToPass = self.movieArray[index.row];

    // Get the new view controller using [segue destinationViewController].
    detailViewController *detailVC = [segue destinationViewController];

    // Pass the selected object to the new view controller.
    detailVC.detailDict = dataToPass;


}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    // reuses the single template of a arbitrary movie cell with unique identifier
    singleMovieCell *movieCell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    NSDictionary *movie = self.movieArray[indexPath.row];
    
    // renders title of movie and overview wrt to properties
    movieCell.movieTitle.text = movie[@"title"];
    movieCell.movieDescription.text = movie[@"overview"];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = movie[@"poster_path"];
    NSString *completePosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:completePosterURLString];
    [movieCell.movieImage setImageWithURL:posterURL];
    
    return movieCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movieArray.count;
}


@end
