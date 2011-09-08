/*
 Copyright (c) 2011 Christian Beer
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
#import <Foundation/Foundation.h>

@interface NSMutableString (VCard)

- (void) appendBegin;
- (void) appendEnd;
- (void) appendVersion:(NSString*)version;

#pragma mark - 3.1 Identification Types

- (void) appendFormattedName:(NSString*)formattedName;
- (void) appendNameWithFamilyName:(NSString*)familyName givenName:(NSString*)givenName additionalNames:(NSString*)additionalNames, ...;
- (void) appendNameWithFamilyName:(NSString*)familyName givenName:(NSString*)givenName;
- (void) appendNickname:(NSString*)nickName;
- (void) appendPhotoURL:(NSURL*)photoURL;
- (void) appendPhotoData:(NSData*)photoData withImageType:(NSString*)type;
- (void) appendBirthday:(NSDate*)birthday;

#pragma mark - 3.2 Delivery Addressing Types

- (void) appendAddressOfType:(NSString*)type withPOBox:(NSString*)poBox 
             extendedAddress:(NSString*)extendedAddress streetAddress:(NSString*)streetAddress
                        city:(NSString*)city stateOrProvince:(NSString*)region
                  postalCode:(NSString*)postalCode country:(NSString*)country;
- (void) appendAddressOfType:(NSString*)type streetAddress:(NSString*)streetAddress
                        city:(NSString*)city stateOrProvince:(NSString*)region
                  postalCode:(NSString*)postalCode;

#pragma mark - 3.3 Telecommunications Addressing Types

- (void) appendPhoneNumber:(NSString*)number ofType:(NSString*)type;
- (void) appendEMail:(NSString*)emailAddress ofType:(NSString*)type;

#pragma mark - 3.5 Organizational Types

- (void) appendTitle:(NSString*)title;
- (void) appendRole:(NSString*)role;
- (void) appendOrganization:(NSString*)org;
- (void) appendNote:(NSString*)note;

#pragma mark - 3.6 Explanatory Types

- (void) appendURL:(NSString*)url ofType:(NSString*)type;

#pragma mark - General

- (void) appendType:(NSString*)type withValue:(NSString*)value;
- (void) appendType:(NSString*)type withValues:(NSString*)firstValue, ...;

- (void) appendType:(NSString*)type withParameters:(NSDictionary*)parameters value:(NSString*)value;
- (void) appendType:(NSString*)type withParameters:(NSDictionary*)parameters values:(NSString*)firstValue, ...;

@end
