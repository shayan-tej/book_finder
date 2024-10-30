import 'package:flutter/material.dart';
import 'package:book_finder/pages/book_details.dart';
import 'package:book_finder/pages/favorites_screen.dart';
import 'package:book_finder/pages/home_screen.dart';
import 'package:book_finder/pages/saved_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Book Finder',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/home': (context) => const HomeScreen(),
          '/saved': (context) => const SavedScreen(),
          '/favorites': (context) => const FavoritesScreen(),
          '/details': (context) => const BookDetailsScreen(),
        },
        home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SavedScreen(),
    const FavoritesScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("E-Books"),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.save), label: "Saved"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favorites")
        ],
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        unselectedItemColor:
            Theme.of(context).colorScheme.surfaceContainerHighest,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}
