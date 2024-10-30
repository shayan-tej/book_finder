import 'package:flutter/material.dart';
import 'package:book_finder/db/database_helper.dart';
import 'package:book_finder/models/book.dart';
import 'package:book_finder/utils/book_details_arguments.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
          future: DatabaseHelper.instance.getFavorites(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              List<Book> favBooks = snapshot.data!;
              return ListView.builder(
                  itemCount: favBooks.length,
                  itemBuilder: (context, index) {
                    Book book = favBooks[index];
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/details",
                            arguments: BookDetailsArguments(
                                itemBook: book, isFromSavedScreen: true));
                      },
                      child: Card(
                        child: ListTile(
                          leading: Image.network(
                              book.imageLinks['thumbnail'] ?? '',
                              fit: BoxFit.cover),
                          title: Text(book.title),
                          subtitle: Text(book.authors.join(", ")),
                          trailing:
                              const Icon(Icons.favorite, color: Colors.red),
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(child: Text("No favorite books found!"));
            }
          },
        ));
  }
}
