import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Screens/home_page.dart';

final supabase = Supabase.instance.client;

void main() async {
  await Supabase.initialize(
    url: "https://xnaichuqxvxkvrltjohv.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhuYWljaHVxeHZ4a3ZybHRqb2h2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE2MTI4MzksImV4cCI6MjA1NzE4ODgzOX0.qm2KJMUM3UhbzOz-U_p2eefRKIAgIcKe6YVt6E01bG4", // Kunci anonim Supabase
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RoadEye',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
