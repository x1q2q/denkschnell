import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Menu menu1 = Menu('Landeskunde', 'menu-building.png');
  Menu menu2 = Menu('Grammatik', 'menu-abc.png');
  Menu menu3 = Menu('Rollenspielen', 'menu-role.png');

  @override
  Widget build(BuildContext context) {
    List<Menu> daftarMenu = [menu1, menu2, menu3];
    return Scaffold(
        backgroundColor: lightblue,
        body: Container(
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
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5),
                          itemCount: daftarMenu.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext ctx, index) {
                            return menuCard(context, daftarMenu[index].nameFile,
                                daftarMenu[index].title, true);
                          }),
                      vSpaceMedium,
                      menuCard(context, 'spiral.png', 'uber uns', false),
                    ],
                  )
                ]))));
  }

  Widget menuCard(
      BuildContext context, String nameFile, String title, bool menuType) {
    return SizedBox.fromSize(
        child: Material(
            color: darkblue,
            borderRadius: BorderRadius.circular(15),
            elevation: 0.1,
            child: InkWell(
                splashColor: darkbrown,
                onTap: () {},
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
                                (menuType) ? Styles.wBold14 : Styles.wBold12),
                        vSpaceXSmall,
                        Container(
                          child: Image.asset('assets/images/$nameFile'),
                          height: (menuType) ? 60 : 30,
                          width: (menuType) ? 60 : 30,
                        ),
                      ],
                    )))));
  }
}

class Menu {
  String title;
  String nameFile;
  Menu(this.title, this.nameFile);
}
