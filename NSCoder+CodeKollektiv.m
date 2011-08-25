//
//  NSCoder+CATransform3D.m
//  ImagesAndTexts
//
//  Created by Jörg Jacobsen on 25.08.11.
//  Copyright 2011 CodeKollektiv. All rights reserved.
//

#import "NSCoder+CodeKollektiv.h"

@implementation NSCoder (CodeKollektiv)

- (void) ck_encodeCATransform3D:(CATransform3D)transform forKey:(NSString *)key
{
    NSString *transformAsString = [NSString stringWithFormat:
                                   @"%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f",
                                   transform.m11,
                                   transform.m12,
                                   transform.m13,
                                   transform.m14,
                                   transform.m21,
                                   transform.m22,
                                   transform.m23,
                                   transform.m24,
                                   transform.m31,
                                   transform.m32,
                                   transform.m33,
                                   transform.m34,
                                   transform.m41,
                                   transform.m42,
                                   transform.m43,
                                   transform.m44];
    
    [self encodeObject:transformAsString forKey:key];
}


- (CATransform3D) ck_decodeCATransform3DForKey:(NSString *)key
{
    NSArray *transformAsArray = [(NSString *)[self decodeObjectForKey:key] componentsSeparatedByString:@", "];
    
    CATransform3D transform = {
        [(NSString *)[transformAsArray objectAtIndex:0] floatValue],
        [(NSString *)[transformAsArray objectAtIndex:1] floatValue],
        [(NSString *)[transformAsArray objectAtIndex:2] floatValue],
        [(NSString *)[transformAsArray objectAtIndex:3] floatValue],
        [(NSString *)[transformAsArray objectAtIndex:4] floatValue],
        [(NSString *)[transformAsArray objectAtIndex:5] floatValue],
        [(NSString *)[transformAsArray objectAtIndex:6] floatValue],
        [(NSString *)[transformAsArray objectAtIndex:7] floatValue],
        [(NSString *)[transformAsArray objectAtIndex:8] floatValue],
        [(NSString *)[transformAsArray objectAtIndex:9] floatValue],
        [(NSString *)[transformAsArray objectAtIndex:10] floatValue],
        [(NSString *)[transformAsArray objectAtIndex:11] floatValue],
        [(NSString *)[transformAsArray objectAtIndex:12] floatValue],
        [(NSString *)[transformAsArray objectAtIndex:13] floatValue],
        [(NSString *)[transformAsArray objectAtIndex:14] floatValue],
        [(NSString *)[transformAsArray objectAtIndex:15] floatValue]
    };
    return transform;
}

@end
