import 'package:floor/floor.dart';

@entity
class Sort {
  @primaryKey
  final int id;
  final String sortType;

  const Sort(this.id, this.sortType);
}
