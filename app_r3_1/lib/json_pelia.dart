// To parse this JSON data, do
//
//     final peliasOutput113 = peliasOutput113FromJson(jsonString);

import 'dart:convert';

PeliasOutput peliasOutputFromJson(String str) => PeliasOutput.fromJson(json.decode(str));

String peliasOutput113ToJson(PeliasOutput data) => json.encode(data.toJson());

class PeliasOutput {
  Geocoding geocoding;
  String type;
  List<Feature> features;
  List<double> bbox;

  PeliasOutput({
    this.geocoding,
    this.type,
    this.features,
    this.bbox,
  });

  factory PeliasOutput.fromJson(Map<String, dynamic> json) => PeliasOutput(
    geocoding: Geocoding.fromJson(json["geocoding"]),
    type: json["type"],
    features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
    bbox: List<double>.from(json["bbox"].map((x) => x.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "geocoding": geocoding.toJson(),
    "type": type,
    "features": List<dynamic>.from(features.map((x) => x.toJson())),
    "bbox": List<dynamic>.from(bbox.map((x) => x)),
  };
}

class Feature {
  FeatureType type;
  Geometry geometry;
  Properties properties;

  Feature({
    this.type,
    this.geometry,
    this.properties,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
    type: featureTypeValues.map[json["type"]],
    geometry: Geometry.fromJson(json["geometry"]),
    properties: Properties.fromJson(json["properties"]),
  );

  Map<String, dynamic> toJson() => {
    "type": featureTypeValues.reverse[type],
    "geometry": geometry.toJson(),
    "properties": properties.toJson(),
  };
}

class Geometry {
  GeometryType type;
  List<double> coordinates;

  Geometry({
    this.type,
    this.coordinates,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    type: geometryTypeValues.map[json["type"]],
    coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "type": geometryTypeValues.reverse[type],
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
  };
}

enum GeometryType { POINT }

final geometryTypeValues = EnumValues({
  "Point": GeometryType.POINT
});

class Properties {
  String id;
  String gid;
  Layer layer;
  Source source;
  String sourceId;
  String name;
  int confidence;
  MatchType matchType;
  Accuracy accuracy;
  Country country;
  CountryGid countryGid;
  CountryA countryA;
  Region region;
  RegionGid regionGid;
  RegionA regionA;
  County county;
  CountyGid countyGid;
  County locality;
  LocalityGid localityGid;
  Continent continent;
  ContinentGid continentGid;
  String label;

  Properties({
    this.id,
    this.gid,
    this.layer,
    this.source,
    this.sourceId,
    this.name,
    this.confidence,
    this.matchType,
    this.accuracy,
    this.country,
    this.countryGid,
    this.countryA,
    this.region,
    this.regionGid,
    this.regionA,
    this.county,
    this.countyGid,
    this.locality,
    this.localityGid,
    this.continent,
    this.continentGid,
    this.label,
  });

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
    id: json["id"],
    gid: json["gid"],
    layer: layerValues.map[json["layer"]],
    source: sourceValues.map[json["source"]],
    sourceId: json["source_id"],
    name: json["name"],
    confidence: json["confidence"],
    matchType: matchTypeValues.map[json["match_type"]],
    accuracy: accuracyValues.map[json["accuracy"]],
    country: countryValues.map[json["country"]],
    countryGid: countryGidValues.map[json["country_gid"]],
    countryA: countryAValues.map[json["country_a"]],
    region: regionValues.map[json["region"]],
    regionGid: regionGidValues.map[json["region_gid"]],
    regionA: regionAValues.map[json["region_a"]],
    county: countyValues.map[json["county"]],
    countyGid: countyGidValues.map[json["county_gid"]],
    locality: countyValues.map[json["locality"]],
    localityGid: localityGidValues.map[json["locality_gid"]],
    continent: continentValues.map[json["continent"]],
    continentGid: continentGidValues.map[json["continent_gid"]],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "gid": gid,
    "layer": layerValues.reverse[layer],
    "source": sourceValues.reverse[source],
    "source_id": sourceId,
    "name": name,
    "confidence": confidence,
    "match_type": matchTypeValues.reverse[matchType],
    "accuracy": accuracyValues.reverse[accuracy],
    "country": countryValues.reverse[country],
    "country_gid": countryGidValues.reverse[countryGid],
    "country_a": countryAValues.reverse[countryA],
    "region": regionValues.reverse[region],
    "region_gid": regionGidValues.reverse[regionGid],
    "region_a": regionAValues.reverse[regionA],
    "county": countyValues.reverse[county],
    "county_gid": countyGidValues.reverse[countyGid],
    "locality": countyValues.reverse[locality],
    "locality_gid": localityGidValues.reverse[localityGid],
    "continent": continentValues.reverse[continent],
    "continent_gid": continentGidValues.reverse[continentGid],
    "label": label,
  };
}

enum Accuracy { POINT }

final accuracyValues = EnumValues({
  "point": Accuracy.POINT
});

enum Continent { NORTH_AMERICA }

final continentValues = EnumValues({
  "North America": Continent.NORTH_AMERICA
});

enum ContinentGid { WHOSONFIRST_CONTINENT_102191575 }

final continentGidValues = EnumValues({
  "whosonfirst:continent:102191575": ContinentGid.WHOSONFIRST_CONTINENT_102191575
});

enum Country { CANADA }

final countryValues = EnumValues({
  "Canada": Country.CANADA
});

enum CountryA { CAN }

final countryAValues = EnumValues({
  "CAN": CountryA.CAN
});

enum CountryGid { WHOSONFIRST_COUNTRY_85633041 }

final countryGidValues = EnumValues({
  "whosonfirst:country:85633041": CountryGid.WHOSONFIRST_COUNTRY_85633041
});

enum County { HAMILTON }

final countyValues = EnumValues({
  "Hamilton": County.HAMILTON
});

enum CountyGid { WHOSONFIRST_COUNTY_890456341 }

final countyGidValues = EnumValues({
  "whosonfirst:county:890456341": CountyGid.WHOSONFIRST_COUNTY_890456341
});

enum Layer { VENUE }

final layerValues = EnumValues({
  "venue": Layer.VENUE
});

enum LocalityGid { WHOSONFIRST_LOCALITY_101735515 }

final localityGidValues = EnumValues({
  "whosonfirst:locality:101735515": LocalityGid.WHOSONFIRST_LOCALITY_101735515
});

enum MatchType { EXACT }

final matchTypeValues = EnumValues({
  "exact": MatchType.EXACT
});

enum Region { ONTARIO }

final regionValues = EnumValues({
  "Ontario": Region.ONTARIO
});

enum RegionA { ON }

final regionAValues = EnumValues({
  "ON": RegionA.ON
});

enum RegionGid { WHOSONFIRST_REGION_85682057 }

final regionGidValues = EnumValues({
  "whosonfirst:region:85682057": RegionGid.WHOSONFIRST_REGION_85682057
});

enum Source { OPENSTREETMAP }

final sourceValues = EnumValues({
  "openstreetmap": Source.OPENSTREETMAP
});

enum FeatureType { FEATURE }

final featureTypeValues = EnumValues({
  "Feature": FeatureType.FEATURE
});

class Geocoding {
  String version;
  String attribution;
  Query query;
  Engine engine;
  int timestamp;

  Geocoding({
    this.version,
    this.attribution,
    this.query,
    this.engine,
    this.timestamp,
  });

  factory Geocoding.fromJson(Map<String, dynamic> json) => Geocoding(
    version: json["version"],
    attribution: json["attribution"],
    query: Query.fromJson(json["query"]),
    engine: Engine.fromJson(json["engine"]),
    timestamp: json["timestamp"],
  );

  Map<String, dynamic> toJson() => {
    "version": version,
    "attribution": attribution,
    "query": query.toJson(),
    "engine": engine.toJson(),
    "timestamp": timestamp,
  };
}

class Engine {
  String name;
  String author;
  String version;

  Engine({
    this.name,
    this.author,
    this.version,
  });

  factory Engine.fromJson(Map<String, dynamic> json) => Engine(
    name: json["name"],
    author: json["author"],
    version: json["version"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "author": author,
    "version": version,
  };
}

class Query {
  String text;
  int size;
  bool private;
  Lang lang;
  int querySize;
  String parser;
  ParsedText parsedText;

  Query({
    this.text,
    this.size,
    this.private,
    this.lang,
    this.querySize,
    this.parser,
    this.parsedText,
  });

  factory Query.fromJson(Map<String, dynamic> json) => Query(
    text: json["text"],
    size: json["size"],
    private: json["private"],
    lang: Lang.fromJson(json["lang"]),
    querySize: json["querySize"],
    parser: json["parser"],
    parsedText: ParsedText.fromJson(json["parsed_text"]),
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "size": size,
    "private": private,
    "lang": lang.toJson(),
    "querySize": querySize,
    "parser": parser,
    "parsed_text": parsedText.toJson(),
  };
}

class Lang {
  String name;
  String iso6391;
  String iso6393;
  bool defaulted;

  Lang({
    this.name,
    this.iso6391,
    this.iso6393,
    this.defaulted,
  });

  factory Lang.fromJson(Map<String, dynamic> json) => Lang(
    name: json["name"],
    iso6391: json["iso6391"],
    iso6393: json["iso6393"],
    defaulted: json["defaulted"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "iso6391": iso6391,
    "iso6393": iso6393,
    "defaulted": defaulted,
  };
}

class ParsedText {
  String subject;

  ParsedText({
    this.subject,
  });

  factory ParsedText.fromJson(Map<String, dynamic> json) => ParsedText(
    subject: json["subject"],
  );

  Map<String, dynamic> toJson() => {
    "subject": subject,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
