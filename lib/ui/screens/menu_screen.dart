import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../../providers/helpers/database_helper.dart';
import '../../providers/helpers/backsound_provider.dart';
import '../../core/string_extension.dart';
import '../../ui/components/svg.dart';
import '../../ui/components/svg_btn_icon.dart';
import 'guide_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

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
  List? answers;
  _getData() async {
    _isLoading = true;
    menus = await dbServ.getAllData('quiz');
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bsProvider = Provider.of<BacksoundProvider>(context);
    return Scaffold(
        backgroundColor: lightblue,
        body: SafeArea(
            child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: Styles.linearGradient,
                ),
                padding: const EdgeInsets.all(15),
                child: Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text('Denkschnell',
                                style: Styles.labelTxtStyle),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  color: Colors.white54,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: SVGBtnIcon(
                                  svg: (!bsProvider.isPlaying)
                                      ? SVG.speakerOff
                                      : SVG.speakerOn,
                                  onTap: () async {
                                    if (!bsProvider.isPlaying) {
                                      await bsProvider
                                          .playAudio("audios/backsong.mp3");
                                    } else {
                                      await bsProvider.stopAudio();
                                    }
                                  },
                                  bgColor: Colors.amber,
                                  splashColor: darkbrown),
                            )
                          ]),
                      vSpaceMedium,
                      Column(
                        children: <Widget>[
                          _isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                      color: darkblue))
                              : menus!.isEmpty
                                  ? const Center(child: Text('empty...'))
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
                    margin: const EdgeInsets.all(5),
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
                            height: (menuType) ? 60 : 35,
                            width: (menuType) ? 60 : 35,
                            margin: EdgeInsets.symmetric(
                                horizontal: (menuType) ? 0 : 10),
                            child: Image.asset('assets/images/$nameFile')),
                      ],
                    )))));
  }
}
