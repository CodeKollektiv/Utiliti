/*
 Copyright (c) 2011 Jörg Jacobsen
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "NSCoder+CodeKollektiv.h"

@implementation NSCoder (CodeKollektiv)

- (void) ck_encodeCATransform3D:(CATransform3D)transform forKey:(NSString *)key
{
    NSString *transformAsString = [NSString stringWithFormat:
                                   @"[%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f]",
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
    NSString *transformAsString = [self decodeObjectForKey:key];
    
    // Strip parentheses
    NSRange range = {1, [transformAsString length] - 2};
    transformAsString = [transformAsString substringWithRange:range];
    
    NSArray *transformAsArray = [transformAsString componentsSeparatedByString:@", "];
    
    CATransform3D transform = {
        .m11 = [[transformAsArray objectAtIndex:0] floatValue],
        .m12 = [[transformAsArray objectAtIndex:1] floatValue],
        .m13 = [[transformAsArray objectAtIndex:2] floatValue],
        .m14 = [[transformAsArray objectAtIndex:3] floatValue],
        .m21 = [[transformAsArray objectAtIndex:4] floatValue],
        .m22 = [[transformAsArray objectAtIndex:5] floatValue],
        .m23 = [[transformAsArray objectAtIndex:6] floatValue],
        .m24 = [[transformAsArray objectAtIndex:7] floatValue],
        .m31 = [[transformAsArray objectAtIndex:8] floatValue],
        .m32 = [[transformAsArray objectAtIndex:9] floatValue],
        .m33 = [[transformAsArray objectAtIndex:10] floatValue],
        .m34 = [[transformAsArray objectAtIndex:11] floatValue],
        .m41 = [[transformAsArray objectAtIndex:12] floatValue],
        .m42 = [[transformAsArray objectAtIndex:13] floatValue],
        .m43 = [[transformAsArray objectAtIndex:14] floatValue],
        .m44 = [[transformAsArray objectAtIndex:15] floatValue]
    };
    return transform;
}

@end
