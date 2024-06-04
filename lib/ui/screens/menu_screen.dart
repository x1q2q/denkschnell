import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../../providers/helpers/database_helper.dart';
import 'guide_screen.dart';
import '../../core/string_extension.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
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

  List? menus;
  _getData() async {
    _isLoading = true;
    menus = await dbServ.getAllData('quiz');
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightblue,
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.all(15),
                child: Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      Text('Denkschnell', style: Styles.labelTxtStyle),
                      vSpaceMedium,
                      Column(
                        children: <Widget>[
                          _isLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                      color: darkblue))
                              : menus!.isEmpty
                                  ? Text('kosong...')
                                  : GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 150,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10),
                                      itemCount: menus?.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (BuildContext ctx, index) {
                                        return menuCard(
                                            context,
                                            menus?[index]['id'],
                                            menus?[index]['file'] + '.png',
                                            menus?[index]['title'],
                                            menus?[index]['description'],
                                            true);
                                      }),
                          vSpaceLarge,
                          menuCard(context, '0', 'spiral.png', 'über uns', '',
                              false),
                        ],
                      )
                    ])))));
  }

  // String capitalize(String teks) {
  //   return "${teks[0].toUpperCase()}${teks.substring(1).toLowerCase()}";
  // }

  Widget menuCard(BuildContext context, String id, String nameFile,
      String title, String desc, bool menuType) {
    return SizedBox.fromSize(
        child: Material(
            color: darkblue,
            borderRadius: BorderRadius.circular(15),
            elevation: 0.1,
            child: InkWell(
                splashColor: darkbrown,
                onTap: () {
                  if (id != '0') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GuideScreen(
                                quizId: id,
                                title: title,
                                file: nameFile,
                                description: desc)));
                  } else {
                    Navigator.pushNamed(context, '/aboutus-screen');
                  }
                },
                borderRadius: BorderRadius.circular(15),
                child: Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(title.capitalize(),
                            style:
                                (menuType) ? Styles.wBold13 : Styles.wBold10),
                        vSpaceXSmall,
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: (menuType) ? 0 : 10),
                          child: Image.asset('assets/images/$nameFile'),
                          height: (menuType) ? 60 : 35,
                          width: (menuType) ? 60 : 35,
                        ),
                      ],
                    )))));
  }
}
