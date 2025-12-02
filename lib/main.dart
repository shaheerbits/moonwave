import 'package:flutter/material.dart';
import 'package:moonwave/pages/discover_page.dart';
import 'package:moonwave/providers/songs_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SongsProvider(),),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Inter'
        )
      ),
      debugShowCheckedModeBanner: false,
      home: const DiscoverPage(),
    );
  }
}
