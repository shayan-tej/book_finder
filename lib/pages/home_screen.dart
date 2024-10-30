import 'package:flutter/material.dart';
import 'package:book_finder/components/gridview_widget.dart';
import 'package:book_finder/models/book.dart';
import 'package:book_finder/network/network.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Network network = Network();
  List<Book> _books = [];
  Future<void> _searchBooks(String query) async {
    try {
      List<Book> books = await network.searchBooks(query);
      setState(() {
        _books = books;
      });
      print("Books: ${books.toString()}");
    } catch (e) {
      print("Didn't get anything...");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          decoration: const InputDecoration(
              hintText: "Search Books",
              suffixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
          onSubmitted: (query) => _searchBooks(query),
        ),
      ),
      GridViewWidget(books: _books)
    ])));
  }
}
