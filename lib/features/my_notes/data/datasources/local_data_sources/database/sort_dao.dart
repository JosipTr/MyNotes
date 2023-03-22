import 'package:floor/floor.dart';

import '../../../../domain/entities/sort.dart';

@dao
abstract class SortDao {
  @Query('SELECT sortType FROM Sort WHERE id=1')
  Future<String?> getSortType();
  @insert
  Future<void> insertSort(Sort sort);

  @update
  Future<void> updateSort(Sort sort);
}
