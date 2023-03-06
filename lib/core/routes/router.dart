import 'package:flutter_notes/features/my_notes/presentation/pages/add_modify_note_page.dart';
import 'package:go_router/go_router.dart';

import '../../features/my_notes/presentation/pages/home_page.dart';

// GoRouter configuration
final router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      routes: <RouteBase>[
        GoRoute(
          path: 'addNote',
          builder: (context, state) => const AddModifyNotePage(),
        ),
      ],
    ),
  ],
);
