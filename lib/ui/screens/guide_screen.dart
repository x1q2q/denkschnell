import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/styles.dart';
import '../../ui/components/svg_btn_icon.dart';
import '../../core/ui_helper.dart';
import '../../ui/components/svg.dart';
import '../../ui/components/card_custom.dart';
import '../../core/string_extension.dart';
import '../../providers/helpers/backsound_provider.dart';

class GuideScreen extends StatefulWidget {
  final String quizId;
  final String title;
  final String description;
  final String file;
  const GuideScreen(
      {super.key,
      required this.quizId,
      required this.title,
      required this.description,
      required this.file});

  @override
  State<GuideScreen> createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String content = widget.description;
    final bsProvider = Provider.of<BacksoundProvider>(context);
    return Scaffold(
        backgroundColor: lightblue,
        body: SafeArea(
            child: Container(
                decoration: const BoxDecoration(
                  gradient: Styles.linearGradient,
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                margin: const EdgeInsets.only(right: 20),
                                child: Text(
                                  widget.title.capitalize(),
                                  style: Styles.bBold15,
                                ))
                          ]),
                      Image.asset('assets/images/${widget.file}',
                          width: 60, height: 60),
                      vSpaceSmall,
                      const Text('Petunjuk Penggunaan',
                          style: Styles.titleBarStyle),
                      vSpaceSmall,
                      CardCustom(
                          parentContext: context,
                          teks: content.replaceAll("-", "\n"),
                          isCenter: false),
                      vSpaceSmall,
                      SVGBtnIcon(
                          svg: SVG.nextIcon,
                          bgColor: green,
                          onTap: () async {
                            if (widget.quizId == '1') {
                              Navigator.pushNamed(context, '/quiz1-screen');
                            } else if (widget.quizId == '2') {
                              // implements forwardchaining algorithm
                              Navigator.pushNamed(context, '/quiz2-screen');
                            } else if (widget.quizId == '3') {
                              Navigator.pushNamed(context, '/quiz3-screen');
                            }
                          },
                          splashColor: Colors.teal),
                      vSpaceSmall,
                      const Text('Denkschnell', style: Styles.sLabelTxtStyle)
                    ]))));
  }
}
