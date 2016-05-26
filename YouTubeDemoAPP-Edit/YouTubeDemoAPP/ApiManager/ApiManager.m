//
//  ApiManager.m
//  YouTubeDemoAPP
//
//  Created by Shyla PC on 5/23/16.
//  Copyright © 2016 Mobinius.com. All rights reserved.
//

#import "ApiManager.h"
#import "Constant.h"

@implementation ApiManager


+ (ApiManager *)sharedManager
{
    static ApiManager *instance = nil;
    
    if(instance == nil)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
            instance = [[ApiManager alloc] init];
        });
    }
    
    return instance;
}


-(void)getYouTubeList:(NSString *)playlistId withPart:(NSString *)partSeperatedbyComma completion:(void (^)(id,int,NSError *))handler{
    
  NSString *QueryStr=@"snippet,contentDetails,status";
    NSString *escapedString = [QueryStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *strUrl = [NSString stringWithFormat:@"%@%@part=%@&maxResults=11&playlistId=UUK8sQmJBp8GCxrOtXWBpyEA&key=%@",WEBSERVICE,PLAYLIST,escapedString,APIKEY];

    NSLog(@"strUrl =%@",strUrl);
    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;

        if (error == nil) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSError *err;
                id jsonResp = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
                NSLog(@"json %@",jsonResp);
                handler(jsonResp,(int)[httpResponse statusCode],nil);
                
            });
        }
        else{
            
            NSLog(@"error %@",[error localizedDescription]);
            handler(nil,0,error);
        }
    }] resume];
}


-(void)getCommentsforVideo:(NSString *)Videoid withCompletion:(void (^)(id,int,NSError *))handler;
{
    NSString *QueryStr=@"snippet";
    NSString *escapedString = [QueryStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *strUrl = [NSString stringWithFormat:@"%@%@part=%@&videoId=%@&key=%@",WEBSERVICE,COMMENTS,escapedString,Videoid,APIKEY];
    NSLog(@"strUrl =%@",strUrl);
    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        
        if (error == nil) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSError *err;
                id jsonResp = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
                NSLog(@"json %@",jsonResp);
                handler(jsonResp,(int)[httpResponse statusCode],nil);
                
            });
        }
        else{
            
            NSLog(@"error %@",[error localizedDescription]);
            handler(nil,0,error);
        }
    }] resume];


}
@end
