//
//  ViewController.h
//  YouTubeDemoAPP
//
//  Created by Shyla PC on 5/23/16.
//  Copyright © 2016 Mobinius.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainVideoCellTableViewCell.h"
#import "SecondaryVideoTVCell.h"
//A controller responsible for listing the videos
@interface ViewController : UIViewController<MainVideoCellTableViewCellDelegate,SecondaryVideoTVCellDelegate>
@property(nonatomic ,retain)NSMutableArray *videoDetailArray;

@property (weak, nonatomic) IBOutlet UITableView *videoTable;
@end

