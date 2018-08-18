#import "magic-the-gathering.h"

#define λ(decl, expr) (^(decl) { return (expr); })

static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

@interface LEAExtras (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface LEACard (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface LEALegalityElement (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface LEARuling (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation LEABooster
+ (NSDictionary<NSString *, LEABooster *> *)values
{
    static NSDictionary<NSString *, LEABooster *> *values;
    return values = values ? values : @{
        @"common": [[LEABooster alloc] initWithValue:@"common"],
        @"rare": [[LEABooster alloc] initWithValue:@"rare"],
        @"uncommon": [[LEABooster alloc] initWithValue:@"uncommon"],
    };
}

+ (LEABooster *)common { return LEABooster.values[@"common"]; }
+ (LEABooster *)rare { return LEABooster.values[@"rare"]; }
+ (LEABooster *)uncommon { return LEABooster.values[@"uncommon"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return LEABooster.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation LEAColorIdentity
+ (NSDictionary<NSString *, LEAColorIdentity *> *)values
{
    static NSDictionary<NSString *, LEAColorIdentity *> *values;
    return values = values ? values : @{
        @"B": [[LEAColorIdentity alloc] initWithValue:@"B"],
        @"G": [[LEAColorIdentity alloc] initWithValue:@"G"],
        @"R": [[LEAColorIdentity alloc] initWithValue:@"R"],
        @"U": [[LEAColorIdentity alloc] initWithValue:@"U"],
        @"W": [[LEAColorIdentity alloc] initWithValue:@"W"],
    };
}

+ (LEAColorIdentity *)b { return LEAColorIdentity.values[@"B"]; }
+ (LEAColorIdentity *)g { return LEAColorIdentity.values[@"G"]; }
+ (LEAColorIdentity *)r { return LEAColorIdentity.values[@"R"]; }
+ (LEAColorIdentity *)u { return LEAColorIdentity.values[@"U"]; }
+ (LEAColorIdentity *)w { return LEAColorIdentity.values[@"W"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return LEAColorIdentity.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation LEAColor
+ (NSDictionary<NSString *, LEAColor *> *)values
{
    static NSDictionary<NSString *, LEAColor *> *values;
    return values = values ? values : @{
        @"Black": [[LEAColor alloc] initWithValue:@"Black"],
        @"Blue": [[LEAColor alloc] initWithValue:@"Blue"],
        @"Green": [[LEAColor alloc] initWithValue:@"Green"],
        @"Red": [[LEAColor alloc] initWithValue:@"Red"],
        @"White": [[LEAColor alloc] initWithValue:@"White"],
    };
}

+ (LEAColor *)black { return LEAColor.values[@"Black"]; }
+ (LEAColor *)blue { return LEAColor.values[@"Blue"]; }
+ (LEAColor *)green { return LEAColor.values[@"Green"]; }
+ (LEAColor *)red { return LEAColor.values[@"Red"]; }
+ (LEAColor *)white { return LEAColor.values[@"White"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return LEAColor.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation LEALayout
+ (NSDictionary<NSString *, LEALayout *> *)values
{
    static NSDictionary<NSString *, LEALayout *> *values;
    return values = values ? values : @{
        @"normal": [[LEALayout alloc] initWithValue:@"normal"],
    };
}

+ (LEALayout *)normal { return LEALayout.values[@"normal"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return LEALayout.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation LEAFormat
+ (NSDictionary<NSString *, LEAFormat *> *)values
{
    static NSDictionary<NSString *, LEAFormat *> *values;
    return values = values ? values : @{
        @"Brawl": [[LEAFormat alloc] initWithValue:@"Brawl"],
        @"Commander": [[LEAFormat alloc] initWithValue:@"Commander"],
        @"Legacy": [[LEAFormat alloc] initWithValue:@"Legacy"],
        @"Modern": [[LEAFormat alloc] initWithValue:@"Modern"],
        @"Standard": [[LEAFormat alloc] initWithValue:@"Standard"],
        @"Vintage": [[LEAFormat alloc] initWithValue:@"Vintage"],
    };
}

+ (LEAFormat *)brawl { return LEAFormat.values[@"Brawl"]; }
+ (LEAFormat *)commander { return LEAFormat.values[@"Commander"]; }
+ (LEAFormat *)legacy { return LEAFormat.values[@"Legacy"]; }
+ (LEAFormat *)modern { return LEAFormat.values[@"Modern"]; }
+ (LEAFormat *)standard { return LEAFormat.values[@"Standard"]; }
+ (LEAFormat *)vintage { return LEAFormat.values[@"Vintage"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return LEAFormat.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation LEALegalityEnum
+ (NSDictionary<NSString *, LEALegalityEnum *> *)values
{
    static NSDictionary<NSString *, LEALegalityEnum *> *values;
    return values = values ? values : @{
        @"Banned": [[LEALegalityEnum alloc] initWithValue:@"Banned"],
        @"Legal": [[LEALegalityEnum alloc] initWithValue:@"Legal"],
        @"Restricted": [[LEALegalityEnum alloc] initWithValue:@"Restricted"],
    };
}

+ (LEALegalityEnum *)banned { return LEALegalityEnum.values[@"Banned"]; }
+ (LEALegalityEnum *)legal { return LEALegalityEnum.values[@"Legal"]; }
+ (LEALegalityEnum *)restricted { return LEALegalityEnum.values[@"Restricted"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return LEALegalityEnum.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation LEARarity
+ (NSDictionary<NSString *, LEARarity *> *)values
{
    static NSDictionary<NSString *, LEARarity *> *values;
    return values = values ? values : @{
        @"Basic Land": [[LEARarity alloc] initWithValue:@"Basic Land"],
        @"Common": [[LEARarity alloc] initWithValue:@"Common"],
        @"Rare": [[LEARarity alloc] initWithValue:@"Rare"],
        @"Uncommon": [[LEARarity alloc] initWithValue:@"Uncommon"],
    };
}

+ (LEARarity *)basicLand { return LEARarity.values[@"Basic Land"]; }
+ (LEARarity *)common { return LEARarity.values[@"Common"]; }
+ (LEARarity *)rare { return LEARarity.values[@"Rare"]; }
+ (LEARarity *)uncommon { return LEARarity.values[@"Uncommon"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return LEARarity.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation LEASupertype
+ (NSDictionary<NSString *, LEASupertype *> *)values
{
    static NSDictionary<NSString *, LEASupertype *> *values;
    return values = values ? values : @{
        @"Basic": [[LEASupertype alloc] initWithValue:@"Basic"],
    };
}

+ (LEASupertype *)basic { return LEASupertype.values[@"Basic"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return LEASupertype.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation LEAType
+ (NSDictionary<NSString *, LEAType *> *)values
{
    static NSDictionary<NSString *, LEAType *> *values;
    return values = values ? values : @{
        @"Artifact": [[LEAType alloc] initWithValue:@"Artifact"],
        @"Creature": [[LEAType alloc] initWithValue:@"Creature"],
        @"Enchantment": [[LEAType alloc] initWithValue:@"Enchantment"],
        @"Instant": [[LEAType alloc] initWithValue:@"Instant"],
        @"Land": [[LEAType alloc] initWithValue:@"Land"],
        @"Sorcery": [[LEAType alloc] initWithValue:@"Sorcery"],
    };
}

+ (LEAType *)artifact { return LEAType.values[@"Artifact"]; }
+ (LEAType *)creature { return LEAType.values[@"Creature"]; }
+ (LEAType *)enchantment { return LEAType.values[@"Enchantment"]; }
+ (LEAType *)instant { return LEAType.values[@"Instant"]; }
+ (LEAType *)land { return LEAType.values[@"Land"]; }
+ (LEAType *)sorcery { return LEAType.values[@"Sorcery"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return LEAType.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

static id map(id collection, id (^f)(id value)) {
    id result = nil;
    if ([collection isKindOfClass:NSArray.class]) {
        result = [NSMutableArray arrayWithCapacity:[collection count]];
        for (id x in collection) [result addObject:f(x)];
    } else if ([collection isKindOfClass:NSDictionary.class]) {
        result = [NSMutableDictionary dictionaryWithCapacity:[collection count]];
        for (id key in collection) [result setObject:f([collection objectForKey:key]) forKey:key];
    }
    return result;
}

#pragma mark - JSON serialization

LEAExtras *_Nullable LEAExtrasFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : [LEAExtras fromJSONDictionary:json];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

LEAExtras *_Nullable LEAExtrasFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return LEAExtrasFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable LEAExtrasToData(LEAExtras *extras, NSError **error)
{
    @try {
        id json = [extras JSONDictionary];
        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:kNilOptions error:error];
        return *error ? nil : data;
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

NSString *_Nullable LEAExtrasToJSON(LEAExtras *extras, NSStringEncoding encoding, NSError **error)
{
    NSData *data = LEAExtrasToData(extras, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation LEAExtras
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"name": @"name",
        @"code": @"code",
        @"gathererCode": @"gathererCode",
        @"magicCardsInfoCode": @"magicCardsInfoCode",
        @"releaseDate": @"releaseDate",
        @"border": @"border",
        @"type": @"type",
        @"booster": @"booster",
        @"mkm_name": @"mkmName",
        @"mkm_id": @"mkmID",
        @"cards": @"cards",
    };
}

+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error
{
    return LEAExtrasFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return LEAExtrasFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[LEAExtras alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _booster = map(_booster, λ(id x, [LEABooster withValue:x]));
        _cards = map(_cards, λ(id x, [LEACard fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = LEAExtras.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:LEAExtras.properties.allValues] mutableCopy];

    for (id jsonName in LEAExtras.properties) {
        id propertyName = LEAExtras.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"booster": map(_booster, λ(id x, [x value])),
        @"cards": map(_cards, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}

- (NSData *_Nullable)toData:(NSError *_Nullable *)error
{
    return LEAExtrasToData(self, error);
}

- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return LEAExtrasToJSON(self, encoding, error);
}
@end

@implementation LEACard
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"artist": @"artist",
        @"cmc": @"cmc",
        @"id": @"identifier",
        @"imageName": @"imageName",
        @"layout": @"layout",
        @"legalities": @"legalities",
        @"manaCost": @"manaCost",
        @"mciNumber": @"mciNumber",
        @"multiverseid": @"multiverseid",
        @"name": @"name",
        @"originalText": @"originalText",
        @"originalType": @"originalType",
        @"printings": @"printings",
        @"rarity": @"rarity",
        @"rulings": @"rulings",
        @"text": @"text",
        @"type": @"type",
        @"types": @"types",
        @"reserved": @"reserved",
        @"power": @"power",
        @"subtypes": @"subtypes",
        @"toughness": @"toughness",
        @"colorIdentity": @"colorIdentity",
        @"flavor": @"flavor",
        @"colors": @"colors",
        @"supertypes": @"supertypes",
        @"variations": @"variations",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[LEACard alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _layout = [LEALayout withValue:(id)_layout];
        _legalities = map(_legalities, λ(id x, [LEALegalityElement fromJSONDictionary:x]));
        _rarity = [LEARarity withValue:(id)_rarity];
        _rulings = map(_rulings, λ(id x, [LEARuling fromJSONDictionary:x]));
        _types = map(_types, λ(id x, [LEAType withValue:x]));
        _colorIdentity = map(_colorIdentity, λ(id x, [LEAColorIdentity withValue:x]));
        _colors = map(_colors, λ(id x, [LEAColor withValue:x]));
        _supertypes = map(_supertypes, λ(id x, [LEASupertype withValue:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = LEACard.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:LEACard.properties.allValues] mutableCopy];

    for (id jsonName in LEACard.properties) {
        id propertyName = LEACard.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"layout": [_layout value],
        @"legalities": map(_legalities, λ(id x, [x JSONDictionary])),
        @"rarity": [_rarity value],
        @"rulings": NSNullify(map(_rulings, λ(id x, [x JSONDictionary]))),
        @"types": map(_types, λ(id x, [x value])),
        @"colorIdentity": NSNullify(map(_colorIdentity, λ(id x, [x value]))),
        @"colors": NSNullify(map(_colors, λ(id x, [x value]))),
        @"supertypes": NSNullify(map(_supertypes, λ(id x, [x value]))),
    }];

    return dict;
}
@end

@implementation LEALegalityElement
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"format": @"format",
        @"legality": @"legality",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[LEALegalityElement alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _format = [LEAFormat withValue:(id)_format];
        _legality = [LEALegalityEnum withValue:(id)_legality];
    }
    return self;
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:LEALegalityElement.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"format": [_format value],
        @"legality": [_legality value],
    }];

    return dict;
}
@end

@implementation LEARuling
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"date": @"date",
        @"text": @"text",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[LEARuling alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:LEARuling.properties.allValues];
}
@end

NS_ASSUME_NONNULL_END
