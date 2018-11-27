//
//  HttpLoader.h
//  BreakPoint
//
//  Created by qianfeng on 14-11-26.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface HttpLoader : NSObject<NSURLConnectionDataDelegate>{
 
    NSFileManager *_fileManage;
    NSURLConnection *_connection;
    NSFileHandle *_handle;
    void(^progressBlock)(float value,float size);
}
@property(nonatomic,assign)unsigned long long cacheFileSize;
@property(nonatomic,assign)unsigned long long needLoadFileSize;
@property(nonatomic,assign)unsigned long long fullLoadFileSize;
@property(nonatomic,assign)unsigned long long loadedFileSize;
+(HttpLoader *)share;
-(void)loadWithUrl:(NSString *)path getblocks:(void(^)(float value,float size))blocks;

-(void)stopLoad;


@end
