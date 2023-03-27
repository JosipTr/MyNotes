import 'package:floor/floor.dart';

import '../../domain/entities/sort.dart';

@entity
class SortModel extends Sort {
  SortModel({required super.id, required super.sortType});

  factory SortModel.fromSort(Sort sort) {
    return SortModel(
      id: sort.id,
      sortType: sort.sortType,
    );
  }

  Sort toSort() {
    return Sort(
      id: id,
      sortType: sortType,
    );
  }
}
