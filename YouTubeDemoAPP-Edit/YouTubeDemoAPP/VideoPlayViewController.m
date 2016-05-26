//
//  VideoPlayViewController.m
//  YouTubeDemoAPP
//
//  Created by Shyla PC on 5/24/16.
//  Copyright © 2016 Mobinius.com. All rights reserved.
//

#import "VideoPlayViewController.h"
#import "ApiManager.h"
#import "MBVideoDetails.h"
#import "CommentsTVCell.h"
@interface VideoPlayViewController ()

@end

@implementation VideoPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.videoTitel;
    [self.playerView loadWithVideoId:self.videoID ];    // Do any additional setup after loading the view.
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.videoComntArray = [[NSMutableArray alloc]init];
    [[ApiManager sharedManager]getCommentsforVideo:self.videoID withCompletion:^(id json, int status, NSError *error) {
        if (error==nil || status==200) {
            NSLog(@"json  -- %@",json);
            if ([[json valueForKey:@"items"]count]) {
                for (int i=0; i<[[json valueForKey:@"items"] count]; i++) {
                    NSDictionary *dict=[[json valueForKey:@"items"] objectAtIndex:i];
                    NSDictionary *dictSnip=[dict valueForKey:@"snippet"] ;
                    
                    MBVideoDetails *video= [[MBVideoDetails alloc] init];
                    video.commenttext=[NSString stringWithFormat:@"%@",[[[dictSnip objectForKey:@"topLevelComment"] objectForKey:@"snippet"]  objectForKey:@"textDisplay"] ];
                    NSLog(@"%@",video.commenttext);
                    
                    video.imageurl=[NSString stringWithFormat:@"%@",[[[dictSnip objectForKey:@"topLevelComment"] objectForKey:@"snippet"]  objectForKey:@"authorProfileImageUrl"] ];
                    video.name=[NSString stringWithFormat:@"%@",[[[dictSnip objectForKey:@"topLevelComment"] objectForKey:@"snippet"]  objectForKey:@"authorDisplayName"] ];
                    [self.videoComntArray addObject:video];
                }
            }
            [self.VideoCommentTable reloadData];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - TableView Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.videoComntArray count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"CommentsTV";
    CommentsTVCell *cell = (CommentsTVCell *)[self.VideoCommentTable dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CommentsTV" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    MBVideoDetails *detailsList=[[MBVideoDetails alloc]init];
    detailsList=[self.videoComntArray objectAtIndex:indexPath.row];
    cell.userNAME.text=detailsList.name;
    cell.userComments.text=detailsList.commenttext;
    NSURL *url = [NSURL URLWithString:detailsList.imageurl];
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    // MyCell *updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                    if (cell)
                        cell.userImage.image = image;
                });
            }
        }
    }];
    [task resume];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 74; //hardcoded, to be improved.
}

@end
