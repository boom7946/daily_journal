import 'package:daily_journal/utils/hive_helper.dart';
import 'package:daily_journal/view/home/main.dart';
import 'package:daily_journal/view_model/journal_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => JournalViewModel())],
      child: MaterialApp(
        title: 'Daily Journal',
        theme: ThemeData(
          useMaterial3: false,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
