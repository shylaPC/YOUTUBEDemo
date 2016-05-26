//
//  CommentsTVCell.h
//  YouTubeDemoAPP
//
//  Created by Shyla PC on 5/25/16.
//  Copyright © 2016 Mobinius.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentsTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userNAME;
@property (weak, nonatomic) IBOutlet UITextView *userComments;

@end
