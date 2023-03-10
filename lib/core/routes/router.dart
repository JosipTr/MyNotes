import 'package:flutter_notes/features/my_notes/presentation/pages/add_modify_note_page.dart';
import 'package:flutter_notes/features/my_notes/presentation/pages/search_note_page.dart';
import 'package:go_router/go_router.dart';

import '../../features/my_notes/domain/entities/note.dart';
import '../../features/my_notes/presentation/pages/home_page.dart';
import '../../features/my_notes/presentation/pages/transition_page.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: const HomePage(),
      ),
      routes: [
        GoRoute(
          path: 'addNote',
          builder: (context, state) => AddModifyNotePage(
            note: state.extra as Note?,
          ),
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: const AddModifyNotePage(),
          ),
        ),
        GoRoute(
          path: 'searchNote',
          builder: (context, state) => const SearchNotePage(),
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: const SearchNotePage(),
          ),
        ),
      ],
    ),
  ],
);
