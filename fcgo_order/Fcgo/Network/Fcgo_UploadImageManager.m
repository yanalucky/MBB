//
//  Fcgo_UploadImageManager.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/15.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_UploadImageManager.h"
#import "UpYun.h"
#define yUpYunBucket       @"feichanggou"
#define yUpyunCode         @"A1V9K/SSxmwOOvYoI7YC+u9Knz0="
#define yApiHostImg        @"http://feichanggou.b0.upaiyun.com/"
#define zqAllFaceImage     @"uploads/images/userimg/"

@implementation Fcgo_UploadImageManager
{
    __block NSMutableArray   *m_uploadArr;
    NSOperationQueue *m_opQueue;
    int    m_curUpload;
    int    m_uploadCount;
    __block NSMutableArray   *m_imageIdArr;
}

+ (Fcgo_UploadImageManager *)shareInstance
{
    static Fcgo_UploadImageManager  *handle;
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        handle=[[Fcgo_UploadImageManager  alloc] init];
    });
    return handle;
}

-(void)uploadImageFromImageArray:(NSMutableArray  *)imageArr
{
    NSArray   *tmpArr = [[NSArray  alloc] initWithArray:(NSArray *)imageArr];
    m_uploadArr = [NSMutableArray   arrayWithArray:tmpArr];
    if (tmpArr  && [tmpArr  count]>0) {
        NSInvocationOperation   *tmpOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(uploadData:) object:m_uploadArr];
        if (nil==m_opQueue) {
            m_opQueue=[NSOperationQueue new];
        }
        [m_opQueue  addOperation:tmpOperation];
    }
    else{
        if (_delegate && [_delegate  respondsToSelector:@selector(uploadImagesSucceed:)]) {
            [_delegate  uploadImagesSucceed:m_uploadArr];
        }
    }
}

-(void)uploadData:(id)data
{
    m_imageIdArr=[[NSMutableArray  alloc] init];
    // UploadHandle   *handle = [UploadHandle  shareInstance];
    [self  setUploadData:data];
    [self  startUpload];
}

-(void)setUploadData:(id)data
{
    m_uploadArr = [NSMutableArray  arrayWithArray:(NSArray *)data];
}

-(void)startUpload
{
    m_uploadCount=(int)[m_uploadArr  count];
    m_curUpload=0;
    [self  uploadAData:m_curUpload];
}

-(void)uploadAData:(NSInteger)nIndex
{
    if (nIndex<m_uploadArr.count) {
        id  object = [m_uploadArr  objectAtIndex:nIndex];
        //如果是图片  进行传递
        if ([object isKindOfClass:[UIImage  class]]) {
            
            //            UIImage  *onnn = (UIImage *)object;
            //            if (onnn.imageOrientation==UIImageOrientationRight) {
            //                onnn=[self  image:onnn rotation:UIImageOrientationRight];
            //            }
            //            ZqLog(@"-----%f-----%f",onnn.size.width,onnn.size.height);
            
            [self  upLoadImageWithImage:(UIImage *)object];
        }
        else
        {
            //链接  直接跳过
            if ([object isKindOfClass:[NSString class]]) {
                NSMutableString *mutaString=[NSMutableString stringWithFormat:@"%@",object];
                [mutaString replaceCharactersInRange:NSMakeRange(0, 32) withString:@""];
                [m_uploadArr replaceObjectAtIndex:nIndex withObject:mutaString];
            }
            [self  uploadNext];
        }
    }
    else
    {
        if (_delegate && [_delegate  respondsToSelector:@selector(uploadImagesSucceed:)]) {
            //            if (self.handleType==UploadHandleTypeNormal) {
            //                [_delegate  uploadImagesSucceed:m_imageIdArr];
            //            }
            //            else{
            //                [_delegate  uploadImagesSucceed:m_uploadArr];
            //            }
            [_delegate  uploadImagesSucceed:m_imageIdArr];
        }
    }
}
-(void)uploadNext
{
    m_curUpload++;
    [self  uploadAData:m_curUpload];
}

//对图片进行压缩
-(NSData *)OnlyCompressToDataWithImage:(UIImage *)OldImage
                              FileSize:(NSInteger)FileSize
{
    CGFloat compression    = 1.0f;
    CGFloat minCompression = 0.001f;
    NSData *imageData = UIImageJPEGRepresentation(OldImage,
                                                  compression);
    float scale = 0.1;
    while ((compression > minCompression)&&
           (imageData.length>FileSize))
    {
        compression -= scale;
        imageData = UIImageJPEGRepresentation(OldImage,
                                              compression);
    }
    return imageData;
}


-(void)upLoadImageWithImage:(UIImage *)image
{
    NSData   *data = [self OnlyCompressToDataWithImage:image FileSize:1024*200];
    //NSData   *data = UIImageJPEGRepresentation(image, 0.8);
    [UPYUNConfig sharedInstance].DEFAULT_BUCKET = yUpYunBucket;
    [UPYUNConfig sharedInstance].DEFAULT_PASSCODE = yUpyunCode;
    __block UpYun *uy = [[UpYun alloc] init];
    uy.successBlocker = ^(NSURLResponse *response, id responseData) {
        if (responseData && [responseData isKindOfClass:[NSDictionary  class]]){
            NSString *urlStr=[NSString stringWithFormat:@"%@%@",yApiHostImg,[responseData objectForKey:@"url"]];
            [m_imageIdArr  addObject:urlStr];
            //上传成功  进行下一张传递
            [self  uploadNext];
        }
    };
    uy.failBlocker=^(NSError *error)
    {
        //上传失败  对当前照片进行重传
        [self  uploadAData:m_curUpload];
    };
    [uy uploadFile:data saveKey:[self getSaveKeyWith:@"png"]];
}


- (NSString * )getSaveKeyWith:(NSString *)suffix{
    return [NSString stringWithFormat:@"%@/%@.%@",zqAllFaceImage,[self getDateString], suffix];
}

- (NSString *)getDateString {
    NSDate *curDate = [NSDate date];//获取当前日期
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];//这里去掉 具体时间 保留日期
    NSString * curTime = [formater stringFromDate:curDate];
    
    curTime = [NSString stringWithFormat:@"%@-%@", curTime, [Fcgo_Tools uuidString]];
    return curTime;
}


@end
