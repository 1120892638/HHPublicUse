//
//  HHMyNetworking.m
//  MeileTang
//
//  Created by admin on 2019/6/19.
//  Copyright © 2019 douzi. All rights reserved.
//

#import "HHMyNetworking.h"
#import "AFNetworking.h"
#import "ViewInstance.h"

static HHMyNetworking *_instance;

@interface HHMyNetworking ()

@property (nonatomic,strong) AFHTTPSessionManager *manager;

@end

@implementation HHMyNetworking

+ (instancetype)sharedInstance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _instance = [[HHMyNetworking alloc] init];
    });
    return _instance;
}

- (instancetype)init{
    if (self = [super init]) {
        self.manager = [AFHTTPSessionManager manager];
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.manager.requestSerializer.timeoutInterval = 90;
        
    }
    return self;
}

//取消当前请求
- (void)cancleRequestTask{
    if ([self.manager.tasks count] > 0) {
        NSLog(@"返回时取消网络请求");
        [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    }
}

#pragma mark -- GET请求 --
- (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id))success
                 failure:(void (^)(NSError *))failure {
    [self setToken:@"urlencoded"];
    [self.manager GET:URLString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *dataDic = [self dataToDic:responseObject];
            
            if ([self judgeUsertokenError:[dataDic[@"code"] integerValue]]) {
                success(dataDic);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark -- POST请求 --
- (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id))success
                  failure:(void (^)(NSError *))failure {
    [self setToken:@"urlencoded"];
    [self.manager POST:URLString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *dataDic = [self dataToDic:responseObject];
            
            if ([self judgeUsertokenError:[dataDic[@"code"] integerValue]]) {
                success(dataDic);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


#pragma mark -- POST/GET网络请求 --
- (void)requestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                        type:(HttpRequestType)type
                     success:(void (^)(id))success
                     failure:(void (^)(NSError *))failure {
    
    [self setToken:@"urlencoded"];
    switch (type) {
        case HttpRequestTypeGet:
        {
            [self.manager GET:URLString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    NSDictionary *dataDic = [self dataToDic:responseObject];
                    if ([self judgeUsertokenError:[dataDic[@"code"] integerValue]]) {
                        success(dataDic);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        case HttpRequestTypePost:
        {
            [self.manager POST:URLString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    NSDictionary *dataDic = [self dataToDic:responseObject];
                    if ([self judgeUsertokenError:[dataDic[@"code"] integerValue]]) {
                        success(dataDic);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        case HttpRequestTypePut:
        {
            [self.manager PUT:URLString parameters:parameters headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    NSDictionary *dataDic = [self dataToDic:responseObject];
                    if ([self judgeUsertokenError:[dataDic[@"code"] integerValue]]) {
                        success(dataDic);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        case HttpRequestTypeDelete:
        {
            [self.manager DELETE:URLString parameters:parameters headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    NSDictionary *dataDic = [self dataToDic:responseObject];
                    if ([self judgeUsertokenError:[dataDic[@"code"] integerValue]]) {
                        success(dataDic);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
            
        }
            break;
    }
}

#pragma mark -- 上传图片 --
- (void)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                uploadParam:(NSArray <UploadParam *>*)uploadArr
            uploadVedioPath:(NSString *)vedioPath
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError * error))failure {
    if (uploadArr.count == 0) {
        success(@{@"ret":@"0"});
        return;
    }
    [self setToken:@"formData"];
    [self.manager POST:URLString parameters:parameters headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < uploadArr.count; i++) {
            @autoreleasepool{
                UploadParam *uploadParam = [uploadArr objectAtIndex:i];
                [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.filename mimeType:uploadParam.mimeType];
            }
        }
        if (vedioPath.length > 0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.mp3", str];
            
            NSError *error;
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:vedioPath] name:@"voice" fileName:fileName mimeType:@"application/octet-stream" error:&error];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *dic = [self dataToDic:responseObject];
            if ([self judgeUsertokenError:[dic[@"code"] integerValue]]) {
                success(dic);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark 上传视频加封面图片
- (void)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                uploadParam:(NSArray <UploadParam *>*)uploadArr
             uploadVedioUrl:(NSURL *)vedioUrl
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError * error))failure {
    [self setToken:@"formData"];
    [self.manager POST:URLString parameters:parameters headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < uploadArr.count; i++) {
            UploadParam *uploadParam = [uploadArr objectAtIndex:i];
            [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.filename mimeType:uploadParam.mimeType];
        }
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.mp4", str];
        NSError *error;
        [formData appendPartWithFileURL:vedioUrl name:@"file" fileName:fileName mimeType:@"video/mp4" error:&error];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *dic = [self dataToDic:responseObject];
            if ([self judgeUsertokenError:[dic[@"code"] integerValue]]) {
                success(dic);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark 上传pdf文件
- (void)uploadPDFfileWithURLString:(NSString *)URLString
                        parameters:(id)parameters
                           fileData:(NSData *)fileData
                           fileName:(NSString *)fileName
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError * error))failure {

    [self setToken:@"formData"];
    [self.manager POST:URLString parameters:parameters headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileData name:@"file" fileName:fileName mimeType:@"application/octet-stream"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *dic = [self dataToDic:responseObject];
            if ([self judgeUsertokenError:[dic[@"code"] integerValue]]) {
                success(dic);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark 解析数据 NSdata --> NSdictionary
- (NSDictionary *)dataToDic:(id)resoponse{
    NSError *error;
    id dic = [NSJSONSerialization JSONObjectWithData:resoponse options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments error:&error];
    if ([dic isKindOfClass:[NSString class]]) {
        NSData *jsonData = [dic dataUsingEncoding:NSUTF8StringEncoding];
        dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                              options:NSJSONReadingMutableContainers
                                                error:nil];
        
    }else if([dic isKindOfClass:[NSDictionary class]]){
        return dic;
    }
    return @{};
}

- (void)setTokenInfo:(NSString *)token{
    if (token > 0) {
        [self.manager.requestSerializer setValue:token forHTTPHeaderField:@"API-User-Token"];
    }
}

//设置token
- (void)setToken:(NSString *)contentType{
    if([contentType isEqualToString:@"formData"]){
        [self.manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
        self.manager.requestSerializer.timeoutInterval = 60;
    }else{
        [self.manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    }
}

//Usertoken过期或错误
- (BOOL)judgeUsertokenError:(NSInteger)code{
//    if ((code == 40002) && ![KWindow.rootViewController isKindOfClass:[UserLogMainController class]]) {
//        NSLog(@"%@",KWindow.rootViewController);
//        //退出的时候删除别名
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:PersonUserDefaultKey];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        [UserInstance attempDealloc];
//        //删除本地推送
//        [GlobalModel deleteLocalNotification];
//        UserLogMainController *vc = [[UserLogMainController alloc] init];
//        KWindow.rootViewController = [[BaseNavController alloc] initWithRootViewController:vc];
//        [GlobalModel showTipToView:KWindow andTipText:@"您的登录已过期，请重新登录。"];
//        return NO;
//    }
    return YES;
}

- (void)postJSONWithURLString:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(id))success
                      failure:(void (^)(NSError *))failure {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:parameters error:nil];
    [manager POST:URLString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)putJSONWithURLString:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(id))success
                      failure:(void (^)(NSError *))failure {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager PUT:URLString parameters:parameters headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

//文件下载
-(void)downloadFileFromServer:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(id))success
                      failure:(void (^)(NSError *))failure {
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    NSURLSessionDownloadTask *download = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%f",1.0 *downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        NSLog(@"targetPath:%@",targetPath);
        NSLog(@"fullPath:%@",fullPath);
        return [NSURL fileURLWithPath:fullPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            failure(error);
        }else{
            success(filePath);
        }
    }];
    [download resume];
}

//删除 Body传值
- (void)requestForDeleteBody:(NSString *)URLString
                     listArr:(NSMutableArray *)listArr
                     success:(void (^)(id))success
                     failure:(void (^)(NSError *))failure {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:listArr options:NSJSONWritingPrettyPrinted error:nil];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    //如果你不需要在请求体里传参 那就参数放入parameters里面
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"DELETE" URLString:URLString parameters:nil error:nil];
    request.timeoutInterval= 10;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;
    [[manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failure(error);
        }else{
            NSDictionary *dataDic = [self dataToDic:responseObject];
            if ([self judgeUsertokenError:[dataDic[@"code"] integerValue]]) {
                success(dataDic);
            }
        }
    }] resume];
}

//批量上传 Body传值
- (void)postBodyJSONWithURLString:(NSString *)URLString
                     listArr:(NSMutableArray *)listArr
                     success:(void (^)(id))success
                     failure:(void (^)(NSError *))failure {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:listArr options:NSJSONWritingPrettyPrinted error:nil];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    //如果你不需要在请求体里传参 那就参数放入parameters里面
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:nil error:nil];
    request.timeoutInterval= 10;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;
    [[manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failure(error);
        }else{
            NSDictionary *dataDic = [self dataToDic:responseObject];
            if ([self judgeUsertokenError:[dataDic[@"code"] integerValue]]) {
                success(dataDic);
            }
        }
    }] resume];
}


@end
