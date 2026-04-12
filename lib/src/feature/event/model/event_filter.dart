class EventFilter {
  final int cityId;
  final String? search;

  EventFilter({
    required this.cityId,
    this.search,
  });

  Map<String, Object?> toJson() => {
    'cityId': cityId,
    'search': ?search,
  };
}

enum EventSort {
  byDefault('default'),
  date('date'),
  priceAsc('priceAsc'),
  priceDesc('priceDesc'),
  ;

  final String id;

  const EventSort(this.id);
}
