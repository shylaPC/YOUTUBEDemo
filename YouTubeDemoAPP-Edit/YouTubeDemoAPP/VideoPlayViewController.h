//
//  VideoPlayViewController.h
//  YouTubeDemoAPP
//
//  Created by Shyla PC on 5/24/16.
//  Copyright © 2016 Mobinius.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

@interface VideoPlayViewController : UIViewController
@property(nonatomic,strong)NSString *videoID;
@property(nonatomic,strong)NSString *videoTitel;
@property(nonatomic ,retain)NSMutableArray *videoComntArray;

@property (weak, nonatomic) IBOutlet YTPlayerView *playerView;
@property (weak, nonatomic) IBOutlet UITableView *VideoCommentTable;

@end
