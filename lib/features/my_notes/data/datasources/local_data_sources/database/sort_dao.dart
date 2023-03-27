import 'package:floor/floor.dart';

import '../../../models/sort_model.dart';

@dao
abstract class SortDao {
  @Query('SELECT sortType FROM SortModel WHERE id=1')
  Future<String?> getSortType();
  @insert
  Future<void> insertSort(SortModel sort);

  @Query('UPDATE SortModel SET sortType=:sortType WHERE id=1')
  Future<void> updateSort(String sortType);
}
