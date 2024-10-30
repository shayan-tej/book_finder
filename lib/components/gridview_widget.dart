import 'package:flutter/material.dart';
import 'package:book_finder/models/book.dart';
import 'package:book_finder/utils/book_details_arguments.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({
    super.key,
    required List<Book> books,
  }) : _books = books;

  final List<Book> _books;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.builder(
            itemCount: _books.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.6),
            itemBuilder: (contex, index) {
              Book book = _books[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to details screen
                      Navigator.pushNamed(contex, '/details',
                          arguments: BookDetailsArguments(
                              itemBook: book, isFromSavedScreen: false));
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Image.network(
                              book.imageLinks['thumbnail'] ?? '',
                              scale: 1.2),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(book.title,
                              style: Theme.of(context).textTheme.titleSmall,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(book.authors.join(", "),
                              style: Theme.of(context).textTheme.bodySmall,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
