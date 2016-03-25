
#import "WXDataServer.h"
#import "AFNetworking.h"

/**
 *  1 URL 可以不需要编码，内部处理
 *  2 存在支持头的问题，text/JSON text/xml text/html ....
 *  3 没有解析XML，data -》 NSXMLParser，你自己代理方法，自己解析
 *  4 iOS 5 提供解析框架
 */


@implementation WXDataServer

+ (void)requestURL:(NSString *)urlstring
        httpMethod:(NSString *)method
            params:(NSMutableDictionary *)parmas
              file:(NSDictionary *)files
           success:(void (^)(id data))success
              fail:(void (^)(NSError *error))fail
{
    
    // 1 拼接地址
    NSString *requestURL = [baseUrl stringByAppendingPathComponent:urlstring];
    
    //    // 2. 拼接token
    //    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //    [parmas setObject:delegate.sinaweibo.accessToken forKey:@"access_token"];
    
    // 3 编码
    // NSString *encodeURL = [requestURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // 3. 构造一个操作对象的管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 4.1
    // 设置解析格式JSON,默认JSON
    // 设置解析XML [AFXMLParserResponseSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
    // 这里要注意一下，不同的接口，我们在这里拼接一下可能会出错
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
//    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];

    
    if ([[method uppercaseString] isEqualToString:@"GET"]) {

        // 4 GET请求
//        [manager GET:requestURL
//          parameters:parmas
//             success:^(AFHTTPRequestOperation *operation, id responseObject) {
////                [progress hide:YES];
//                 if (success) {
//                     success(responseObject);
//                 }
//             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
////                 [progress hide:YES];
//                 if (fail) {
//                     fail(error);
//                 }
//             }];
        
        [manager GET:requestURL parameters:parmas progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (fail) {
                fail(error);
            }
        }];
        
        
    }else if ([[method uppercaseString] isEqualToString:@"POST"]) {
        
        if (files == nil) {
            
            // POST 不包括文件
//            [manager POST:requestURL
//               parameters:parmas
//                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                      if (success) {
//                          success(responseObject);
//                      }
//                  }
//                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                      if (fail) {
//                          fail(error);
//                      }
//                  }];
            [manager POST:requestURL parameters:parmas progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (fail) {
                    fail(error);
                }
            }];
            
        }else{
            
            // POST 包括文件的，这个方法返回一个AFHTTPRequestOperation对象operation
//            [manager POST:requestURL
//               parameters:parmas
//constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//    
//    if (files != nil) {
//        for (id key in files) {
//        
//        id value = files[key];
//        [formData appendPartWithFileData:value
//                                    name:@"uploadFile"
//                                fileName:key
//                                mimeType:@"application/octet-stream"];
//        }
//    }
//    
//    
//}success:^(AFHTTPRequestOperation *operation, id responseObject) {
////    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
////    [progress hide:YES];
//    if (success) {
//        success(responseObject);
//    }
//    
//}failure:^(AFHTTPRequestOperation *operation, NSError *error) {
////    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
////    [progress hide:YES];
//    if (fail) {
//        fail(error);
//    }
//}];
            
            [manager POST:requestURL parameters:parmas constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                if (files != nil) {
                    for (id key in files) {
                        
                        id value = files[key];
                        [formData appendPartWithFileData:value
                                                    name:@"uploadFile"
                                                fileName:key
                                                mimeType:@"application/octet-stream"];
                    }
                }
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (fail) {
                    fail(error);
                }
            }];
            
            //            // 设置上传的进度监听
            //            [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            //
            //                CGFloat progress = totalBytesWritten / (CGFloat)totalBytesExpectedToWrite;
            //                NSLog(@"progress : %f",progress);
            //
            //            }];
        }
    }
}

+ (void)requestURL:(NSString *)urlstring
        httpMethod:(NSString *)method
            params:(NSMutableDictionary *)parmas
              file:(NSDictionary *)files
          fileName:(NSString *)fileName
          mimeType:(NSString *)mimeType
           success:(void (^)(id data))success
              fail:(void (^)(NSError *error))fail
{
    
    // 1 拼接地址
    NSString *requestURL = [imgsUrl stringByAppendingPathComponent:urlstring];
    
//    // 2. 拼接token
//    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [parmas setObject:delegate.sinaweibo.accessToken forKey:@"access_token"];
    
    // 3 编码
   // NSString *encodeURL = [requestURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // 3. 构造一个操作对象的管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 4.1
    // 设置解析格式JSON,默认JSON
    // 设置解析XML [AFXMLParserResponseSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
    // 这里要注意一下，不同的接口，我们在这里拼接一下可能会出错
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
//    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];

    
    if ([[method uppercaseString] isEqualToString:@"GET"]) {
        
        // 4 GET请求
//        [manager GET:requestURL
//          parameters:parmas
//             success:^(AFHTTPRequestOperation *operation, id responseObject) {
////                 [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
////                 [progress hide:YES];
//                 if (success) {
//                     success(responseObject);
//                 }
//             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
////                 [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
////                 [progress hide:YES];
//                 if (fail) {
//                     fail(error);
//                 }
//             }];
        
        [manager GET:requestURL parameters:parmas progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (fail) {
                fail(error);
            }
        }];
        
        
    }else if ([[method uppercaseString] isEqualToString:@"POST"]) {
        
        if (files == nil) {
            
            // POST 不包括文件
//          [manager POST:requestURL
//              parameters:parmas
//                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
////                     [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
////                     [progress hide:YES];
//                     if (success) {
//                         success(responseObject);
//                     }
//                 }
//                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
////                     [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
////                     [progress hide:YES];
//                     if (fail) {
//                         
//                         fail(error);
//                     }
//                 }];
            
            [manager POST:requestURL parameters:parmas progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (fail) {
                    fail(error);
                }
            }];
            
        }else{
            
            // POST 包括文件的，这个方法返回一个AFHTTPRequestOperation对象operation
//            [manager POST:requestURL
//              parameters:parmas
//        constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//            
//            if (files != nil) {
//                for (id key in files) {
//                    
//                    id value = files[key];
//                    [formData appendPartWithFileData:value
//                                                name:fileName//集合名
//                                            fileName:key//文件名
//                                            mimeType:mimeType];
//                }
//            }
//            
//            
//        }success:^(AFHTTPRequestOperation *operation, id responseObject) {
//
//                     if (success) {
//                         success(responseObject);
//                     }
//            
//                 }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//
//                     if (fail) {
//                         fail(error);
//                         
//                     }
//                 }];
            
            [manager POST:requestURL parameters:parmas constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                if (files != nil) {
                    for (id key in files) {
                        id value = files[key];
                        [formData appendPartWithFileData:value
                                                    name:fileName//集合名
                                                fileName:key//文件名
                                                mimeType:mimeType];
                    }
                }
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (fail) {
                    fail(error);
                }
            }];
            
//            // 设置上传的进度监听
//            [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
//                
//                CGFloat progress = totalBytesWritten / (CGFloat)totalBytesExpectedToWrite;
//                NSLog(@"progress : %f",progress);
//                
//            }];
        }
    }
}

@end
