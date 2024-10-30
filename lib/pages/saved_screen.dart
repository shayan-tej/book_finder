import 'package:flutter/material.dart';
import 'package:book_finder/db/database_helper.dart';
import 'package:book_finder/models/book.dart';
import 'package:book_finder/utils/book_details_arguments.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Book>>(
          future: DatabaseHelper.instance.realAllBooks(),
          builder: (context, snapshot) => snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Book book = snapshot.data![index];
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/details",
                            arguments: BookDetailsArguments(
                                itemBook: book, isFromSavedScreen: true));
                      },
                      child: Card(
                          child: ListTile(
                        title: Text(book.title),
                        leading: Image.network(
                            book.imageLinks['thumbnail'] ?? '',
                            fit: BoxFit.cover),
                        trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              DatabaseHelper.instance.deleteBook(book.id);
                              setState(() {});
                            }),
                        subtitle: Column(
                          children: [
                            Text(book.authors.join(", ")),
                            ElevatedButton.icon(
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
                                    : "Add to Favorites"))
                          ],
                        ),
                      )),
                    );
                  })
              : const Center(child: CircularProgressIndicator())),
    );
  }
}
