import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../components/svg_btn_icon.dart';
import '../components/svg.dart';
import '../../providers/helpers/database_helper.dart';
import '../../providers/helpers/backsound_provider.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
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
    final bsProvider = Provider.of<BacksoundProvider>(context);
    return Scaffold(
        backgroundColor: lightblue,
        body: SafeArea(
            child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: Styles.linearGradient,
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                    color: Colors.white54,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                child: SVGBtnIcon(
                                    svg: SVG.homeIcon,
                                    onTap: () async {
                                      Navigator.of(context).pop();
                                    },
                                    bgColor: red,
                                    splashColor: Colors.red),
                              ),
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
                            Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: const Text(
                                  'Tentang Kami',
                                  style: Styles.bBold15,
                                ))
                          ]),
                      vSpaceSmall,
                      SizedBox.fromSize(
                          child: Material(
                              color: darkblue,
                              borderRadius: BorderRadius.circular(15),
                              elevation: 0.1,
                              child: InkWell(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        child: Image.asset(
                                            'assets/images/spiral.png'),
                                      ))))),
                      vSpaceSmall,
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: _isLoading
                              ? const CircularProgressIndicator(color: darkblue)
                              : abouts!.isEmpty
                                  ? const Text('...')
                                  : Text(
                                      abouts?[0]['app_descriptions']
                                          .replaceAll('_', '\n'),
                                      style: Styles.bBold12,
                                      textAlign: TextAlign.justify,
                                    )),
                      vSpaceSmall,
                      Image.asset(
                        'assets/images/logo.png',
                        height: 70,
                        width: 70,
                      ),
                      const Text('Denkschnell', style: Styles.xsLabelTxtStyle)
                    ]))));
  }
}
