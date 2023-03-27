import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class Sort extends Equatable {
  @primaryKey
  final int id;
  final String sortType;

  Sort({required this.id, required this.sortType});

  Sort copyWith({int? id, String? sortType}) {
    return Sort(id: id ?? this.id, sortType: sortType ?? this.sortType);
  }

  @override
  List<Object?> get props => [id, sortType];
}
