/*
 Created by Jörg Jacobsen on 25.08.11.
 
 Copyright 2011 CodeKollektiv. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 * Neither the name of the author nor the names of its contributors may be used
 to endorse or promote products derived from this software without specific
 prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
