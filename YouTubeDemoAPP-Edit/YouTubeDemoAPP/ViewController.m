//
//  ViewController.m
//  YouTubeDemoAPP
//
//  Created by Shyla PC on 5/23/16.
//  Copyright © 2016 Mobinius.com. All rights reserved.
//

#import "ViewController.h"
#import "ApiManager.h"
#import "MBVideo.h"
#import "MainVideoCellTableViewCell.h"
#import "SecondaryVideoTVCell.h"
#import "VideoPlayViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _videoDetailArray= [[NSMutableArray alloc]init];
    self.title=@"Video list";
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [[ApiManager sharedManager]getYouTubeList:@""
                                     withPart:@""
                                   completion:^(id json, int status, NSError *error) {
                                       if (error==nil || status==200) {
                                           NSLog(@"json  -- %@",json);
                                           if ([[json valueForKey:@"items"]count]) {
                                               for (int i=0; i<[[json valueForKey:@"items"] count]; i++) {
                                                   NSDictionary *dict=[[json valueForKey:@"items"] objectAtIndex:i];
                                                   NSDictionary *dictSnip=[dict valueForKey:@"snippet"] ;
                                                   
                                                   MBVideo *detailsList= [[MBVideo alloc] init];
                                                   detailsList.title=[NSString stringWithFormat:@"%@",[dictSnip objectForKey:@"title"]];
                                                   detailsList.videoDescription=[NSString stringWithFormat:@"%@",[dictSnip objectForKey:@"description"]];
                                                   detailsList.thumbUrl =[NSString stringWithFormat:@"%@",[[[dictSnip objectForKey:@"thumbnails"] objectForKey:@"default"] objectForKey:@"url"]];
                                                   detailsList.videoId =[NSString stringWithFormat:@"%@",[[dictSnip objectForKey:@"resourceId"] objectForKey:@"videoId"]];
                                                   [_videoDetailArray addObject:detailsList];
                                               }
                                               
                                           }
                                           if ([_videoDetailArray count]>0) {
                                               [self.videoTable reloadData];
                                               [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                           }
                                          
                                           
                                       }
                                       
                                   }];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //We use two diff sections, one more Major video (very forst one) and 2nd one for the smaller vdeo thumb list
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section==0) {
//        return 1; //Major thumb area
//    }else{
//        return ([self.videoDetailArray count]?[self.videoDetailArray count]/2:0 ); //Smaller thumbs devided by 2 as we show 2 thumbs per cell
//    }
    
    
    if ([self.videoDetailArray count]) {
        if (section==0) {
            return 1;
        }else{
            NSLog(@" cells %lu",[self.videoDetailArray count]/2 - 1);
            return ([self.videoDetailArray count]/2 );
        }
    }
    else
        return 0;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        static NSString *simpleTableIdentifier = @"MainVideoCell";
        MainVideoCellTableViewCell *cell = (MainVideoCellTableViewCell *)[self.videoTable dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (cell == nil){
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MainVideoCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        MBVideo *detailsList=[[MBVideo alloc]init];
        detailsList=[self.videoDetailArray objectAtIndex:indexPath.section];
        cell.title.text=detailsList.title;
        cell.descriptVd.text=detailsList.videoDescription;
        cell.thumbImg.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:detailsList.thumbUrl]]];
        cell.PlayMainDelegate = self;
        return cell;
        
    }else{
        SecondaryVideoTVCell *cell = [self.videoTable dequeueReusableCellWithIdentifier:@"SecondaryCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cell) {
            [self.videoTable registerNib:[UINib nibWithNibName:@"SecondaryVideoTVCell" bundle:nil ] forCellReuseIdentifier:@"SecondaryCell"];
            cell= [tableView dequeueReusableCellWithIdentifier:@"SecondaryCell"];
        }
        
        int i;
        if (indexPath.row==0) {
            i=0;
        }else{
            i=1;
        }
        
        cell.PlaySecondDelegate = self;
        MBVideo *detailsList=[[MBVideo alloc]init];
        detailsList=[self.videoDetailArray objectAtIndex:indexPath.row+1 +(indexPath.row*i)];
        cell.titelCell2.text=detailsList.title;
        cell.descriptionCell2.text=detailsList.videoDescription;
        // cell.thumbCell2Img.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:detailsList.thumbUrl]]];
        cell.thumbCell2Img.image=nil;
        NSURL *url = [NSURL URLWithString:detailsList.thumbUrl];
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                UIImage *image = [UIImage imageWithData:data];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // MyCell *updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                        if (cell)
                            cell.thumbCell2Img.image = image;
                    });
                }
            }
        }];
        [task resume];
        
        if (!(indexPath.row==10)) {
            MBVideo *detailsList2=[[MBVideo alloc]init];
            detailsList2=[self.videoDetailArray objectAtIndex:indexPath.row+2+(indexPath.row*i)];
            cell.titelcell3.text=detailsList2.title;
            cell.descriptionCell3.text=detailsList2.videoDescription;
            //  cell.thumbCell3Img.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:detailsList2.thumbUrl]]];
            NSURL *url = [NSURL URLWithString:detailsList2.thumbUrl];
            cell.thumbCell3Img.image=nil;
            NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (data) {
                    UIImage *image = [UIImage imageWithData:data];
                    if (image) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (cell)
                                cell.thumbCell3Img.image = image;
                        });
                    }
                }
            }];
            [task resume];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 414;//hardcoded for now
    }else{
        return 240;//hardcoded for now
    }
}

#pragma cell Delegate Methods

- (void)didPlayButtonClick:(UIButton *)cell onCell:(MainVideoCellTableViewCell *)customCell{
    NSIndexPath *indexPath = [self.videoTable indexPathForCell:customCell];
    MBVideo *detailsList=[[MBVideo alloc]init];
    detailsList=[self.videoDetailArray objectAtIndex:indexPath.section];
    VideoPlayViewController *playVideoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"VideoPlayViewController"];
    playVideoVC.videoID=detailsList.videoId;
    playVideoVC.videoTitel=detailsList.title;
    [self.navigationController pushViewController:playVideoVC animated:NO];
    
}


- (void)didPlayFirstButtonClick:(UIButton *)cell onCell:(SecondaryVideoTVCell *)customCell{
    NSIndexPath *indexPath = [self.videoTable indexPathForCell:customCell];
    MBVideo *detailsList=[[MBVideo alloc]init];
    int i;
    if (indexPath.row==0) {
        i=0;
    }else{
        i=1;
    }
    detailsList=[self.videoDetailArray objectAtIndex:indexPath.row+1 +(indexPath.row*i)];
    VideoPlayViewController *playVideoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"VideoPlayViewController"];
    playVideoVC.videoID=detailsList.videoId;
    playVideoVC.videoTitel=detailsList.title;
    [self.navigationController pushViewController:playVideoVC animated:NO];
}

- (void)didPlaySecondButtonClicked:(UIButton *)cell onCell:(SecondaryVideoTVCell *)customCell{
    NSIndexPath *indexPath = [self.videoTable indexPathForCell:customCell];
    MBVideo *detailsList2=[[MBVideo alloc]init];
    int i;
    if (indexPath.row==0) {
        i=0;
    }else{
        i=1;
    }
    detailsList2=[self.videoDetailArray objectAtIndex:indexPath.row+2+(indexPath.row*i)];
    VideoPlayViewController *playVideoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"VideoPlayViewController"];
    playVideoVC.videoID=detailsList2.videoId;
    playVideoVC.videoTitel=detailsList2.title;
    
    [self.navigationController pushViewController:playVideoVC animated:NO];
}


@end
