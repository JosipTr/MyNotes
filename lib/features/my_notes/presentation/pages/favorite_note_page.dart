import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/empty_list.dart';
import '../widgets/menu.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/strings/string.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';
import '../bloc/note_state.dart';

class FavoriteNotePage extends StatelessWidget {
  const FavoriteNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        actions: [
          IconButton(
              onPressed: () {
                context.pop();
                context.go(searchNotePageRoute);
              },
              icon: const Icon(Icons.search)),
          PopupMenuButton(
            icon: const Icon(Icons.sort),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  children: [
                    Text('By title',
                        style: Theme.of(context).textTheme.labelMedium!),
                  ],
                ),
                onTap: () {},
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Text('By date',
                        style: Theme.of(context).textTheme.labelMedium!),
                  ],
                ),
                onTap: () {},
              ),
            ],
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('Select all'),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
      drawer: const Menu(),
      body: WillPopScope(
        onWillPop: () async {
          context.read<NoteBloc>().add(const GetNotesEvent());
          return true;
        },
        child: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            if (state is Loaded) {
              return ListView.builder(
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(8),
                    elevation: 5,
                    color: state.notes[index].isSelected
                        ? Colors.blueGrey[200]
                        : Theme.of(context).cardColor,
                    child: ListTile(
                      onLongPress: () {},
                      onTap: () {
                        context.go(updateNotePageRoute,
                            extra: state.notes[index]);
                      },
                      title: Text(
                        state.notes[index].title,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.notes[index].description,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Text(
                            state.notes[index].date,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                      trailing: state.notes[index].isSelected
                          ? IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.delete,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            )
                          : IconButton(
                              onPressed: () {},
                              icon: state.notes[index].isFavorite
                                  ? Icon(
                                      Icons.star,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )
                                  : Icon(
                                      Icons.star_border,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                            ),
                    ),
                  );
                },
              );
            } else if (state is Empty) {
              return EmptyList(
                message: state.message,
                iconPath: 'assets/images/favorite.png',
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
