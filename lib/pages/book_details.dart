import 'package:flutter/material.dart';
import 'package:book_finder/db/database_helper.dart';
import 'package:book_finder/models/book.dart';
import 'package:book_finder/utils/book_details_arguments.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as BookDetailsArguments;
    final Book book = args.itemBook;
    final bool isFromSavedScreen = args.isFromSavedScreen;
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              if (book.imageLinks.isNotEmpty)
                Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Image.network(book.imageLinks["thumbnail"] ?? "",
                        fit: BoxFit.cover)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    book.title,
                    style: theme.headlineSmall,
                  ),
                  Text(book.authors.join(", "), style: theme.labelLarge),
                  Text("Published: ${book.publishedDate}",
                      style: theme.bodySmall),
                  Text("Page count: ${book.pageCount}", style: theme.bodySmall),
                  Text(
                    "Language: ${book.language}",
                    style: theme.bodySmall,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: !isFromSavedScreen
                        ? ElevatedButton(
                            onPressed: () async {
                              // save a book to the datase
                              try {
                                int savedInt =
                                    await DatabaseHelper.instance.insert(book);
                                SnackBar snackBar = SnackBar(
                                    content: Text("Book Saved $savedInt"));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } catch (e) {
                                print("Error: $e");
                              }
                            },
                            child: const Text('Save'))
                        : ElevatedButton.icon(
                            onPressed: () async {
                              await DatabaseHelper.instance
                                  .toggleFavoriteStatus(
                                      book.id, !book.isFavorite);
                              setState(() {});
                            },
                            icon: Icon(
                              book.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              color: book.isFavorite ? Colors.red : null,
                            ),
                            label: Text(book.isFavorite
                                ? "Favorite"
                                : "Add to Favorites")),
                  ),
                  const SizedBox(height: 10),
                  Text("Description", style: theme.titleMedium),
                  const SizedBox(height: 5),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.2),
                        border: Border.all(
                            color: Theme.of(context).colorScheme.secondary),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(book.description),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
