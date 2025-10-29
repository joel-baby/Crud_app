import 'package:app/note_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: "https://mpnyshlpmkyzfadcxadz.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wbnlzaGxwbWt5emZhZGN4YWR6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjA4ODk2MTUsImV4cCI6MjA3NjQ2NTYxNX0.vOflBs_cl04yQ5YQBtrMF_BGohD1ZM8mE14FZOVIg4U",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotePage(),
    );
  }
}
