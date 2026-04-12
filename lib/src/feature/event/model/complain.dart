import 'package:meta/meta.dart';

@immutable
class Complain {
  final ComplainType type;
  final String? description;

  const Complain({
    required this.type,
    this.description,
  });

  Map<String, dynamic> toJson() => {
    'type': type.id,
    'description': description,
  };
}

enum ComplainType {
  misinformation('misinformation'),
  illegalContent('illegalContent'),
  scam('scam'),
  other('other'),
  ;

  final String id;

  const ComplainType(this.id);
}
