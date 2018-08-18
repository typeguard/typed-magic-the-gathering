// To parse this JSON:
//
//   NSError *error;
//   LEAExtras *extras = [LEAExtras fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class LEAExtras;
@class LEABooster;
@class LEACard;
@class LEAColorIdentity;
@class LEAColor;
@class LEALayout;
@class LEALegalityElement;
@class LEAFormat;
@class LEALegalityEnum;
@class LEARarity;
@class LEARuling;
@class LEASupertype;
@class LEAType;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface LEABooster : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (LEABooster *)common;
+ (LEABooster *)rare;
+ (LEABooster *)uncommon;
@end

@interface LEAColorIdentity : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (LEAColorIdentity *)b;
+ (LEAColorIdentity *)g;
+ (LEAColorIdentity *)r;
+ (LEAColorIdentity *)u;
+ (LEAColorIdentity *)w;
@end

@interface LEAColor : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (LEAColor *)black;
+ (LEAColor *)blue;
+ (LEAColor *)green;
+ (LEAColor *)red;
+ (LEAColor *)white;
@end

@interface LEALayout : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (LEALayout *)normal;
@end

@interface LEAFormat : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (LEAFormat *)brawl;
+ (LEAFormat *)commander;
+ (LEAFormat *)legacy;
+ (LEAFormat *)modern;
+ (LEAFormat *)standard;
+ (LEAFormat *)vintage;
@end

@interface LEALegalityEnum : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (LEALegalityEnum *)banned;
+ (LEALegalityEnum *)legal;
+ (LEALegalityEnum *)restricted;
@end

@interface LEARarity : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (LEARarity *)basicLand;
+ (LEARarity *)common;
+ (LEARarity *)rare;
+ (LEARarity *)uncommon;
@end

@interface LEASupertype : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (LEASupertype *)basic;
@end

@interface LEAType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (LEAType *)artifact;
+ (LEAType *)creature;
+ (LEAType *)enchantment;
+ (LEAType *)instant;
+ (LEAType *)land;
+ (LEAType *)sorcery;
@end

#pragma mark - Object interfaces

@interface LEAExtras : NSObject
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSString *code;
@property (nonatomic, copy)   NSString *gathererCode;
@property (nonatomic, copy)   NSString *magicCardsInfoCode;
@property (nonatomic, copy)   NSString *releaseDate;
@property (nonatomic, copy)   NSString *border;
@property (nonatomic, copy)   NSString *type;
@property (nonatomic, copy)   NSArray<LEABooster *> *booster;
@property (nonatomic, copy)   NSString *mkmName;
@property (nonatomic, assign) NSInteger mkmID;
@property (nonatomic, copy)   NSArray<LEACard *> *cards;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface LEACard : NSObject
@property (nonatomic, copy)             NSString *artist;
@property (nonatomic, assign)           NSInteger cmc;
@property (nonatomic, copy)             NSString *identifier;
@property (nonatomic, copy)             NSString *imageName;
@property (nonatomic, assign)           LEALayout *layout;
@property (nonatomic, copy)             NSArray<LEALegalityElement *> *legalities;
@property (nonatomic, nullable, copy)   NSString *manaCost;
@property (nonatomic, nullable, copy)   NSString *mciNumber;
@property (nonatomic, assign)           NSInteger multiverseid;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, nullable, copy)   NSString *originalText;
@property (nonatomic, copy)             NSString *originalType;
@property (nonatomic, copy)             NSArray<NSString *> *printings;
@property (nonatomic, assign)           LEARarity *rarity;
@property (nonatomic, nullable, copy)   NSArray<LEARuling *> *rulings;
@property (nonatomic, nullable, copy)   NSString *text;
@property (nonatomic, copy)             NSString *type;
@property (nonatomic, copy)             NSArray<LEAType *> *types;
@property (nonatomic, nullable, strong) NSNumber *reserved;
@property (nonatomic, nullable, copy)   NSString *power;
@property (nonatomic, nullable, copy)   NSArray<NSString *> *subtypes;
@property (nonatomic, nullable, copy)   NSString *toughness;
@property (nonatomic, nullable, copy)   NSArray<LEAColorIdentity *> *colorIdentity;
@property (nonatomic, nullable, copy)   NSString *flavor;
@property (nonatomic, nullable, copy)   NSArray<LEAColor *> *colors;
@property (nonatomic, nullable, copy)   NSArray<LEASupertype *> *supertypes;
@property (nonatomic, nullable, copy)   NSArray<NSNumber *> *variations;
@end

@interface LEALegalityElement : NSObject
@property (nonatomic, assign) LEAFormat *format;
@property (nonatomic, assign) LEALegalityEnum *legality;
@end

@interface LEARuling : NSObject
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *text;
@end

NS_ASSUME_NONNULL_END
