class StringConstants {
  //Emit messages
  static const onFailureMessage = 'Ooops! Something went wrong.';
  static const onInsertNoteFailure = 'Note is not added!';
  static const emptyListMessage = 'No notes added!';
  static const emptyTrashMessage = 'Trash is empty!';
  static const emptyFavoriteMessage = 'You have no favorite notes!';
  static const onUpdateNoteMessage = 'Note successfully updated!';
  static const onInsertNoteMessage = 'Note successfully added!';
  static const onRemoveNoteMessage = 'Note successfully removed!';

  //Routes
  static const homePageRoute = '/';
  static const addNotePageRoute = '/addNote';
  static const searchNotePageRoute = '/searchNote';
  static const updateNotePageRoute = '/updateNote';

  //SortType
  static const titleSortType = 'title';
  static const titleDescSortType = 'titleDesc';
  static const dateSortType = 'date';
  static const dateDescSortType = 'dateDesc';

  //ImageAssetRoute
  static const imageNotesEmpty = 'assets/images/post-it.png';
  static const imageTrashEmpty = 'assets/images/recycle-bin.png';
  static const imageFavoriteEmpty = 'assets/images/favorite.png';

  //AppBarTitle
  static const appbarHomeTitle = 'MyNotes';
  static const appbarFavoriteTitle = 'Favorites';
  static const appbarTrashTitle = 'Trash';

  //AppTitle
  static const appTitle = 'MyNotes';

  //Widget text
  static const selectAll = 'Select all';
  static const unSelectAll = 'Unselect all';
  static const emptyTrash = 'Empty Trash';
  static const byTitle = 'By Title';
  static const byDate = 'By Date';
}
