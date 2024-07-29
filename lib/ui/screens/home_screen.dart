import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../components/card_custom.dart';
import '../../providers/helpers/database_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseHelper dbServ = DatabaseHelper();
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List? abouts;
  _getData() async {
    _isLoading = true;
    abouts = await dbServ.getAllData('about_apps');
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightblue,
        body: SafeArea(
            child: _isLoading
                ? const CircularProgressIndicator(color: darkblue)
                : abouts!.isEmpty
                    ? const Text('...')
                    : Container(
                        decoration: const BoxDecoration(
                          gradient: Styles.linearGradient,
                        ),
                        child: Center(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CardCustom(
                              parentContext: context,
                              teks: abouts?[0]['app_on_start']
                                  .replaceAll('-', '\n'),
                              isCenter: true,
                            ),
                            ElevatedButton(
                              style: Styles.basicBtn,
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/menu-screen');
                              },
                              child: const Text('Next'),
                            )
                          ],
                        )))));
  }
}
