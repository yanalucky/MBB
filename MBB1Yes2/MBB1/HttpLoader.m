//
//  HttpLoader.m
//  BreakPoint
//
//  Created by qianfeng on 14-11-26.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "HttpLoader.h"
//#import "MD5.h"
@implementation HttpLoader

+(HttpLoader *)share{

    static HttpLoader *loader = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        loader = [[HttpLoader alloc]init];
    });
    return loader;

}

-(id)init{

    if(self =[super init])
    {
        _fileManage =[NSFileManager defaultManager];
    }
    return self;

}

-(NSString *)GetLocalDocPath{

    //document的路径
    NSString *path =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];

    path =[path stringByAppendingPathComponent:@"download"];
    //创建文件夹
    if(![_fileManage fileExistsAtPath:path])
    {
        [_fileManage createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return path;
}
-(void)loadWithUrl:(NSString *)path getblocks:(void (^)(float, float))blocks{
    
    progressBlock =[blocks copy];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:path] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30];
    NSArray *arr =[path componentsSeparatedByString:@"/"];
    
    NSString *filepath =[[self GetLocalDocPath] stringByAppendingPathComponent:[arr lastObject]];
    
    _handle = [NSFileHandle fileHandleForWritingAtPath:filepath];
    
    if([_fileManage fileExistsAtPath:filepath])
    {
        //获取文件属性
        NSDictionary *fileInf =[_fileManage attributesOfItemAtPath:filepath error:nil];
        _cacheFileSize = [[fileInf objectForKey:NSFileSize]unsignedLongLongValue];
        //修改请求头
        [request addValue:[NSString stringWithFormat:@"bytes=%qu-",_cacheFileSize] forHTTPHeaderField:@"Range"];
        _loadedFileSize =_cacheFileSize;
    }
    else
    {
        [_fileManage createFileAtPath:filepath contents:nil attributes:nil];
        
        //使用路径初始化句柄
        
        _connection = [NSURLConnection connectionWithRequest:request delegate:self];
    }
   
    
    
}
#pragma mark--下载协议
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [_handle seekToEndOfFile];
    [_handle writeData:data];
    _loadedFileSize = _loadedFileSize +data.length;
    NSLog(@"_loadedFileSize = %llu",_loadedFileSize);
    double tempFullSize =_fullLoadFileSize;
    float size =tempFullSize/1024/1024;
    NSLog(@"size = %f",tempFullSize);
    if(progressBlock)
    {
        
    progressBlock(_loadedFileSize/(1*1024*1024),size);
        
    }
    
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{

    _needLoadFileSize = [response expectedContentLength];
    _fullLoadFileSize = _fullLoadFileSize + _cacheFileSize;

}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
  
    [_handle closeFile];

}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

     [_handle closeFile];

}

-(void)stopLoad{

    [_connection cancel];
    [_handle closeFile];

}


@end
