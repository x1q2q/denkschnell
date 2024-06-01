import 'package:flutter/material.dart';
import '../../core/styles.dart';
import '../../ui/components/svg_btn_icon.dart';
import '../../core/ui_helper.dart';
import '../../ui/components/svg.dart';
import '../../ui/components/card_custom.dart';

class GuideScreen extends StatefulWidget {
  final String quizId;
  final String title;
  final String description;
  final String file;
  GuideScreen(
      {Key? key,
      required this.quizId,
      required this.title,
      required this.description,
      required this.file})
      : super(key: key);

  @override
  State<GuideScreen> createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {
  @override
  Widget build(BuildContext context) {
    String content = widget.description;
    return Scaffold(
        backgroundColor: lightblue,
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5),
                              child: SVGBtnIcon(
                                  svg: SVG.homeIcon,
                                  onTap: () {
                                    Navigator.popAndPushNamed(
                                        context, '/menu-screen');
                                  },
                                  bgColor: red,
                                  splashColor: Colors.red),
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                            ),
                            Container(
                                child: Text(
                                  widget.title,
                                  style: Styles.bBold15,
                                ),
                                margin: EdgeInsets.only(right: 20))
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
                          onTap: () {
                            if (widget.quizId == '1') {
                              Navigator.pushNamed(context, '/quiz1-screen');
                            } else if (widget.quizId == '2') {
                              Navigator.pushNamed(context, '/quiz2-screen');
                            } else if (widget.quizId == '3') {
                              Navigator.pushNamed(context, '/quiz3-screen');
                            }
                          },
                          splashColor: Colors.teal),
                      vSpaceSmall,
                      Text('Denkschnell', style: Styles.sLabelTxtStyle)
                    ])))));
  }
}
