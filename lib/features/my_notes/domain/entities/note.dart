class Note {
  final int? id;
  final String? title;
  final String? content;
  final DateTime dateTime;

  const Note(
      {this.id,
      required this.title,
      required this.content,
      required this.dateTime});
}
