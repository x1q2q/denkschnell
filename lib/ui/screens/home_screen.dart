import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../components/card_custom.dart';
import '../../providers/services/database_service.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseService dbServ = DatabaseService();
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

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightblue,
        body: SafeArea(
            child: _isLoading
                ? CircularProgressIndicator(color: darkblue)
                : abouts!.isEmpty
                    ? Text('...')
                    : Center(
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
                            child: Text('Next'),
                          )
                        ],
                      ))));
  }
}
