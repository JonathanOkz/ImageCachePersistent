//
//  imageCache.h
//  ImageCachePersistent
//
//  Created by Jonathan Oleszkiewicz on 03/09/2015.
//  Copyright (c) 2015 Jonathan Oleszkiewicz.
//  See LICENSE for full license agreement.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonHMAC.h>
#import "imageCachePersistent.h"
#import "imageCacheTemporary.h"

@interface ImageCache : NSObject {
    @private
    ImageCachePersistent    *_imageCachePersistent;
    ImageCacheTemporary     *_imageCacheTemporary;
}


- (nullable ImageCache *)initWithDirectory:(nonnull NSString *)directory;

- (nullable UIImage *)getImageForKey:(nonnull NSString *)key;

- (void)setImage:(nonnull UIImage *)image forKey:(nonnull NSString *)key;


- (nullable UIImage *)getImageTemporaryForKey:(nonnull NSString *)key;

- (void)setImageTemporary:(nonnull UIImage *)image forKey:(nonnull NSString *)key;

- (void)deleteImageTemporaryForKey:(nonnull NSString *)key;

- (void)deleteAllImageTemporary;


- (nullable NSArray*)listImagesPersistentStored;

- (BOOL)imagePersistentExistForKey:(nonnull NSString *)key;

- (nullable UIImage *)getImagePersistentForKey:(nonnull NSString *)key;

- (void)setImagePersistent:(nonnull UIImage *)image forKey:(nonnull NSString *)key cb:(nullable void(^)(BOOL boolean))cb;

- (void)deleteImagePersistentForKey:(nonnull NSString *)key cb:(nullable void (^)(BOOL boolean))cb;

@end
