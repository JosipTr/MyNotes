import 'package:floor/floor.dart';

@entity
class Sort {
  @primaryKey
  final int id;
  final String noteOrder;

  const Sort(this.id, this.noteOrder);
}
