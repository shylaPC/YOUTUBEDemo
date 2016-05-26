//
//  ApiManager.h
//  YouTubeDemoAPP
//
//  Created by Shyla PC on 5/23/16.
//  Copyright © 2016 Mobinius.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiManager : NSObject

+(ApiManager *)sharedManager;

-(void)getYouTubeList:(NSString *)playlistId withPart:(NSString *)partSeperatedbyComma completion:(void (^)(id,int,NSError *))handler;

-(void)getCommentsforVideo:(NSString *)Videoid withCompletion:(void (^)(id,int,NSError *))handler;

@end
