// domain/entities/country_entity.dart

class Country {
  final Name name;

  const Country({required this.name});
}

class Name {
  final String common;
  final String official;
  final Map<String, NativeName>? nativeName;

  const Name({
    required this.common,
    required this.official,
    this.nativeName,
  });
}

class NativeName {
  final String official;
  final String common;

  const NativeName({
    required this.official,
    required this.common,
  });
}
