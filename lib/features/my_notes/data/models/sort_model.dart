import '../../domain/entities/sort.dart';

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
