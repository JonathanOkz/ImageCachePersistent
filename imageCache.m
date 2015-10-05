//
//  imageCache.m
//  ImageCachePersistent
//
//  Created by Jonathan Oleszkiewicz on 03/09/2015.
//  Copyright (c) 2015 Jonathan Oleszkiewicz.
//  See LICENSE for full license agreement.
//

#import "imageCache.h"

@implementation ImageCache


- (ImageCache *)initWithDirectory:(NSString *)directory {
    self = [super init];
    
    _imageCachePersistent = [[ImageCachePersistent alloc] initWithDirectory:directory];
    _imageCacheTemporary = [[ImageCacheTemporary alloc] initWithDirectory:directory];
    
    return self;
}

- (UIImage *)getImageForKey:(NSString *)key {
    UIImage *image = nil;
    NSString *hashKey = [self hashString:key];
    
    image = [_imageCacheTemporary getImageForKey:hashKey];
    if (image) {
        return image;
    } else {
        image = [_imageCachePersistent getImageForKey:hashKey];
        if (image) {
            [_imageCacheTemporary setImage:image forKey:hashKey];
            return image;
        } else {
            return nil;
        }
    }
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key {
    NSString *hashKey = [self hashString:key];
    
    [_imageCachePersistent setImage:image forKey:hashKey cb:^(BOOL boolean) {
        NSLog(@"setImage:%d", boolean);
    }];
    [_imageCacheTemporary setImage:image forKey:hashKey];
}


- (UIImage *)getImageTemporaryForKey:(NSString *)key {
     NSString *hashKey = [self hashString:key];
    return [_imageCacheTemporary getImageForKey:hashKey];
}

- (void)setImageTemporary:(UIImage *)image forKey:(NSString *)key {
     NSString *hashKey = [self hashString:key];
    [_imageCacheTemporary setImage:image forKey:hashKey];
}

- (void)deleteImageTemporaryForKey:(NSString *)key {
     NSString *hashKey = [self hashString:key];
    [_imageCacheTemporary deleteImageForKey:hashKey];
}

- (void)deleteAllImageTemporary {
    [_imageCacheTemporary deleteAllImage];
}


- (NSArray*)listImagesPersistentStored {
    return [_imageCachePersistent listImagesStored];
}

- (BOOL)imagePersistentExistForKey:(NSString *)key {
     NSString *hashKey = [self hashString:key];
    return [_imageCachePersistent imageExistForKey:hashKey];
}

- (UIImage *)getImagePersistentForKey:(NSString *)key {
     NSString *hashKey = [self hashString:key];
    return [_imageCachePersistent getImageForKey:hashKey];
}

- (void)setImagePersistent:(UIImage *)image forKey:(NSString *)key cb:(void(^)(BOOL boolean))cb {
     NSString *hashKey = [self hashString:key];
    [_imageCachePersistent setImage:image forKey:hashKey cb:cb];
}

- (void)deleteImagePersistentForKey:(NSString *)key cb:(void (^)(BOOL boolean))cb {
     NSString *hashKey = [self hashString:key];
    [_imageCachePersistent deleteImageForKey:hashKey cb:cb];
}

-(NSString *)hashString:(NSString *)data {
    
    const char *cKey  = "image";
    const char *cData = [data cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSString *hash;
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", cHMAC[i]];
    hash = output;
    
    return hash;
}

@end
