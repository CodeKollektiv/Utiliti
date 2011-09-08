/*
 Copyright (c) 2011 Christian Beer
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
#import "NSMutableString+VCard.h"

#import "NSData+Base64.h"
#import "NSString+ISO8601.h"

@implementation NSMutableString (VCard)

#pragma mark - 2.1.1 BEGIN and END Type

- (void) appendBegin
{
    [self appendType:@"BEGIN" withValue:@"VCARD"];
}
- (void) appendEnd
{
    [self appendType:@"END" withValue:@"VCARD"];
}

- (void) appendVersion:(NSString*)version
{
    [self appendType:@"VERSION" withValue:version];
}

#pragma mark - 3.1 Identification Types

- (void) appendFormattedName:(NSString*)formattedName 
{
    [self appendType:@"FN" withValue:formattedName];
}

- (void) appendNameWithFamilyName:(NSString*)familyName givenName:(NSString*)givenName additionalNames:(NSString*)additionalNames, ...
{
    [self appendType:@"N" withValues:familyName, givenName, additionalNames];
}
- (void) appendNameWithFamilyName:(NSString*)familyName givenName:(NSString*)givenName
{
    [self appendNameWithFamilyName:familyName givenName:givenName additionalNames:nil];
}

- (void) appendNickname:(NSString*)nickName
{
    [self appendType:@"NICKNAME" withValue:nickName];
}

- (void) appendPhotoURL:(NSURL*)photoURL
{
    NSString *uriString = [NSString stringWithFormat:@"uri:%@", [photoURL absoluteString]];
    [self appendType:@"PHOTO" withParameters:[NSDictionary dictionaryWithObjectsAndKeys:uriString, @"VALUE", nil] 
               value:nil];
}
- (void) appendPhotoData:(NSData*)photoData withImageType:(NSString*)type
{
    NSString *base64String = [photoData base64EncodedString];
    [self appendType:@"PHOTO" withParameters:[NSDictionary dictionaryWithObjectsAndKeys:@"ENCODING", @"b",
                                              @"TYPE", [type uppercaseString],
                                              nil] 
               value:base64String];
}

- (void) appendBirthday:(NSDate*)birthday
{
    [self appendType:@"BDAY" withValue:[birthday isoStringRepresentation]];
}

#pragma mark - 3.2 Delivery Addressing Types

- (void) appendAddressOfType:(NSString*)type withPOBox:(NSString*)poBox 
             extendedAddress:(NSString*)extendedAddress streetAddress:(NSString*)streetAddress
                        city:(NSString*)city stateOrProvince:(NSString*)region
                  postalCode:(NSString*)postalCode country:(NSString*)country
{
    /* The structured type value corresponds,
     in sequence, to the post office box; the extended address; the street
     address; the locality (e.g., city); the region (e.g., state or
     province); the postal code; the country name. When a component value
     is missing, the associated component separator MUST still be
     specified. */
    
    NSDictionary *parameters = nil;
    
    if (type) {
        parameters = [NSDictionary dictionaryWithObject:type forKey:@"TYPE"];
    }
    
    [self appendType:@"ADR" 
      withParameters:parameters 
              values:poBox ? poBox : @"",
                     extendedAddress ? extendedAddress : @"",
                     streetAddress ? streetAddress : @"",
                     city ? city : @"",
                     region ? region : @"",
                     postalCode ? postalCode : @"",
                     country ? country : @"",
                     nil];
}
- (void) appendAddressOfType:(NSString*)type streetAddress:(NSString*)streetAddress
                        city:(NSString*)city stateOrProvince:(NSString*)region
                  postalCode:(NSString*)postalCode
{
    [self appendAddressOfType:type withPOBox:nil extendedAddress:nil
                streetAddress:streetAddress city:city stateOrProvince:nil
                   postalCode:postalCode country:nil];
}

#pragma mark - 3.3 Telecommunications Addressing Types

- (void) appendPhoneNumber:(NSString*)number ofType:(NSString*)type
{
    NSDictionary *parameters = nil;
    
    if (type) {
        parameters = [NSDictionary dictionaryWithObject:type forKey:@"TYPE"];
    }
    
    [self appendType:@"TEL" withParameters:parameters 
               value:number];
}

- (void) appendEMail:(NSString*)emailAddress ofType:(NSString*)type
{
    NSDictionary *parameters = nil;
    
    if (type) {
        parameters = [NSDictionary dictionaryWithObject:type forKey:@"TYPE"];
    }
    
    [self appendType:@"EMAIL" withParameters:parameters 
               value:emailAddress];
}

#pragma mark - 3.5 Organizational Types

- (void) appendTitle:(NSString*)title
{
    [self appendType:@"TITLE" withValue:title];
}

- (void) appendRole:(NSString*)role
{
    [self appendType:@"ROLE" withValue:role];
}

- (void) appendOrganization:(NSString*)org
{
    [self appendType:@"ORG" withValue:org];
}

- (void) appendNote:(NSString*)note
{
    [self appendType:@"NOTE" withValue:note];
}

#pragma mark - 3.6 Explanatory Types

- (void) appendURL:(NSString*)url ofType:(NSString*)type
{
    NSDictionary *parameters = nil;
    
    if (type) {
        parameters = [NSDictionary dictionaryWithObject:type forKey:@"TYPE"];
    }
    
    [self appendType:@"URL" withParameters:parameters 
               value:url];
}

#pragma mark - General

- (void) appendType:(NSString*)type withValue:(NSString*)value
{
    [self appendType:type withParameters:nil values:value, nil];
}
- (void) appendType:(NSString*)type withValues:(NSString*)firstValue, ...
{
    [self appendString:type];
    
    if (firstValue) {
        [self appendFormat:@":%@", firstValue];
        
        va_list args;
        va_start(args, firstValue);
        NSString *value;
        while ((value = va_arg(args, NSString *))) {
            [self appendFormat:@";%@", value];
        }
        va_end(args);
    }
    
    [self appendString:@"\n"];
}

- (void) appendType:(NSString*)type withParameters:(NSDictionary*)parameters value:(NSString*)value
{
    [self appendType:type withParameters:parameters values:value, nil];
}

// appends a text of format "type;parameters...:values" example: "type;parameter1=value;parameter2=value:firstValue;secondValue;..."
- (void) appendType:(NSString*)type withParameters:(NSDictionary*)parameters values:(NSString*)firstValue, ...
{
    [self appendString:type];
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [self appendFormat:@";%@=%@", [key uppercaseString], obj];
    }];
 
    if (firstValue) {
        [self appendFormat:@":%@", firstValue];
        
        va_list args;
        va_start(args, firstValue);
        NSString *value;
        while ((value = va_arg(args, NSString *))) {
            [self appendFormat:@";%@", value];
        }
        va_end(args);
    }
    
    [self appendString:@"\n"];
} 

@end
