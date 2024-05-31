import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Menu menu1 = Menu(1, 'Grammatik', 'menu-abc.png');
  Menu menu2 = Menu(2, 'Landeskunde', 'menu-building.png');
  Menu menu3 = Menu(3, 'Rollenspielen', 'menu-role.png');

  @override
  Widget build(BuildContext context) {
    List<Menu> daftarMenu = [menu1, menu2, menu3];
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
                          GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 150,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                              itemCount: daftarMenu.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext ctx, index) {
                                return menuCard(
                                    context,
                                    daftarMenu[index].id,
                                    daftarMenu[index].nameFile,
                                    daftarMenu[index].title,
                                    true);
                              }),
                          vSpaceLarge,
                          menuCard(context, 0, 'spiral.png', 'über uns', false),
                        ],
                      )
                    ])))));
  }

  Widget menuCard(BuildContext context, int id, String nameFile, String title,
      bool menuType) {
    return SizedBox.fromSize(
        child: Material(
            color: darkblue,
            borderRadius: BorderRadius.circular(15),
            elevation: 0.1,
            child: InkWell(
                splashColor: darkbrown,
                onTap: () {
                  if (id == 1) {
                    Navigator.pushNamed(context, '/quiz1-screen');
                  } else if (id == 2) {
                    Navigator.pushNamed(context, '/quiz2-screen');
                  } else if (id == 3) {
                    Navigator.pushNamed(context, '/quiz3-screen');
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
                        Text(title,
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

class Menu {
  int id;
  String title;
  String nameFile;
  Menu(this.id, this.title, this.nameFile);
}
