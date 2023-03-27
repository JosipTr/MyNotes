import 'package:floor/floor.dart';

import '../../../../domain/entities/sort.dart';
import '../../../models/sort_model.dart';

@dao
abstract class SortDao {
  @Query('SELECT sortType FROM Sort WHERE id=1')
  Future<String?> getSortType();
  @insert
  Future<void> insertSort(SortModel sort);

  @Query('UPDATE Sort SET sortType=:sortType WHERE id=1')
  Future<void> updateSort(String sortType);
}
