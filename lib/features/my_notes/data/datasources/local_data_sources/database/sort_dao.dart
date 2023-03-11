import 'package:floor/floor.dart';

import '../../../../domain/entities/sort.dart';

@dao
abstract class SortDao {
  @Query('SELECT noteOrder FROM Sort WHERE id=1')
  Future<String?> getNoteOrder();
  @insert
  Future<void> insertSort(Sort sort);

  @Query('UPDATE Sort SET noteOrder=:noteOrder WHERE id=1')
  Future<void> updateNoteOrder(String noteOrder);
}
