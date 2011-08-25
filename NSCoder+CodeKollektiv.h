//
//  NSCoder+CATransform3D.h
//  ImagesAndTexts
//
//  Created by Jörg Jacobsen on 25.08.11.
//  Copyright 2011 CodeKollektiv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface NSCoder (CodeKollektiv)

- (void) ck_encodeCATransform3D:(CATransform3D)transform forKey:(NSString *)key;
- (CATransform3D) ck_decodeCATransform3DForKey:(NSString *)key;

@end
