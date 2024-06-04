import 'package:flutter/material.dart';
import '../../core/styles.dart';
import '../../ui/components/svg_btn_icon.dart';
import '../../core/ui_helper.dart';
import '../../ui/components/svg.dart';
import 'package:provider/provider.dart';
import '../../providers/helpers/question_provider.dart';

class Quiz2Screen extends StatefulWidget {
  Quiz2Screen({Key? key}) : super(key: key);

  @override
  State<Quiz2Screen> createState() => _Quiz2ScreenState();
}

class _Quiz2ScreenState extends State<Quiz2Screen> with WidgetsBindingObserver {
  String teksQuestion = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final qProvider = Provider.of<QuestionProvider>(context, listen: false);
      qProvider.fetchQuestion('essay_text', 'level1', false);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final qProvider = Provider.of<QuestionProvider>(context);
    var screenSizes = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: lightblue,
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5),
                              child: SVGBtnIcon(
                                  svg: SVG.homeIcon,
                                  onTap: () async {
                                    final provider =
                                        Provider.of<QuestionProvider>(context,
                                            listen: false);
                                    await provider.refreshIDsQuestion();
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
                                  'Landeskunde',
                                  style: Styles.bBold15,
                                ),
                                margin: EdgeInsets.only(right: 10))
                          ]),
                      vSpaceMedium,
                      Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 0),
                            padding: EdgeInsets.symmetric(
                                vertical: 30, horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            width: screenSizes.width - (screenSizes.width / 8),
                            child: Column(children: <Widget>[
                              Text(
                                qProvider.question?.questionText ??
                                    teksQuestion,
                                style: Styles.bBold12,
                                textAlign: TextAlign.center,
                              )
                            ]),
                          ),
                          Positioned(
                              child: SVG.speakerIcon, left: -10, top: -30),
                        ],
                      ),
                      vSpaceXSmall,
                      cardWhiteHeader(context,
                          qProvider.question?.correctAnswer ?? teksQuestion)
                    ]))));
  }

  Widget cardWhiteHeader(BuildContext context, String teks) {
    var screenSizes = MediaQuery.of(context).size;
    return Center(
        child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      width: (screenSizes.width / 1.5),
      child: Column(children: <Widget>[
        Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: darkbrown,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Text(
              'Weitermachen?',
              style: Styles.wBold15,
              textAlign: TextAlign.center,
            )),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SVGBtnIcon(
                  svg: SVG.modalEditIcon,
                  bgColor: Colors.orange,
                  splashColor: Colors.orangeAccent,
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(32))),
                        context: context,
                        builder: (BuildContext context) => Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: modalSheet(context, teks)));
                  },
                ),
                SVGBtnIcon(
                  svg: SVG.nextIcon,
                  bgColor: green,
                  splashColor: Colors.teal,
                  onTap: () async {
                    final provider =
                        Provider.of<QuestionProvider>(context, listen: false);
                    await provider.fetchQuestion('essay_text', 'level1', true);
                  },
                ),
              ],
            )),
      ]),
    ));
  }

  Widget modalSheet(BuildContext context, String teks) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 280,
      width: MediaQuery.of(context).size.width,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 180,
              child: TextField(
                maxLines: 5,
                decoration: InputDecoration(
                    hintText: teks,
                    hintStyle:
                        TextStyle(color: greyv2, fontWeight: FontWeight.normal),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: grey),
                        borderRadius: BorderRadius.circular(22)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: grey),
                        borderRadius: BorderRadius.circular(22))),
              ),
            ),
            ElevatedButton(
              style: Styles.basicBtn,
              onPressed: () {},
              child: Text('Simpan'),
            )
          ]),
    );
  }
}
