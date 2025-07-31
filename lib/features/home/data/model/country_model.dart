import '../../domain/entities/country.dart';

class CountryModel extends Country {
  const CountryModel({required super.name});

  CountryModel copyWith({Name? name}) {
    return CountryModel(name: name ?? this.name);
  }

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(name: NameModel.fromJson(json['name']));
  }

  Map<String, dynamic> toJson() {
    return {'name': (name as NameModel).toJson()};
  }
}

class NameModel extends Name {
  const NameModel({
    required super.common,
    required super.official,
    super.nativeName,
  });

  NameModel copyWith({
    String? common,
    String? official,
    Map<String, NativeName>? nativeName,
  }) {
    return NameModel(
      common: common ?? this.common,
      official: official ?? this.official,
      nativeName: nativeName ?? this.nativeName,
    );
  }

  factory NameModel.fromJson(Map<String, dynamic> json) {
    Map<String, NativeName>? nativeNameMap;
    if (json['nativeName'] != null) {
      nativeNameMap = <String, NativeName>{};
      (json['nativeName'] as Map<String, dynamic>).forEach((key, value) {
        nativeNameMap![key] = NativeNameModel.fromJson(value);
      });
    }

    return NameModel(
      common: json['common'],
      official: json['official'],
      nativeName: nativeNameMap,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> nativeNameJson = {};
    if (nativeName != null) {
      nativeName!.forEach((key, value) {
        nativeNameJson[key] = (value as NativeNameModel).toJson();
      });
    }

    return {
      'common': common,
      'official': official,
      if (nativeName != null) 'nativeName': nativeNameJson,
    };
  }
}

class NativeNameModel extends NativeName {
  const NativeNameModel({required super.official, required super.common});

  NativeNameModel copyWith({String? official, String? common}) {
    return NativeNameModel(
      official: official ?? this.official,
      common: common ?? this.common,
    );
  }

  factory NativeNameModel.fromJson(Map<String, dynamic> json) {
    return NativeNameModel(official: json['official'], common: json['common']);
  }

  Map<String, dynamic> toJson() {
    return {'official': official, 'common': common};
  }
}
