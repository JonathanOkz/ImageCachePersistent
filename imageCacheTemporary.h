//
//  imageCacheTemporary.h
//  ImageCachePersistent
//
//  Created by Jonathan Oleszkiewicz on 03/09/2015.
//  Copyright (c) 2015 Jonathan Oleszkiewicz.
//  See LICENSE for full license agreement.
//

#import <Foundation/Foundation.h>

@interface ImageCacheTemporary : NSCache {
@private
    NSString    *_directory;
}


- (nullable ImageCacheTemporary *)initWithDirectory:(nonnull NSString *)directory;

- (nullable UIImage *)getImageForKey:(nonnull NSString *)key;

- (void)setImage:(nonnull UIImage *)image forKey:(nonnull NSString *)key;

- (void)deleteImageForKey:(nonnull NSString *)key;

- (void)deleteAllImage;

@end
