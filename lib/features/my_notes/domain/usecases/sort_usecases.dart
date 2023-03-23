import 'package:flutter_notes/features/my_notes/domain/usecases/get_sort_type_usecase.dart';
import 'package:flutter_notes/features/my_notes/domain/usecases/insert_sort_usecase.dart';
import 'package:flutter_notes/features/my_notes/domain/usecases/update_sort_usecase.dart';

class SortUseCases {
  final GetSortTypeUseCase getSortTypeUseCase;
  final InsertSortUseCase insertSortUseCase;
  final UpdateSortUseCase updateSortUseCase;

  const SortUseCases(
      this.getSortTypeUseCase, this.insertSortUseCase, this.updateSortUseCase);
}
