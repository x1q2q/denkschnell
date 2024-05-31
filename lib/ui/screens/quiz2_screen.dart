import 'package:flutter/material.dart';
import '../../core/styles.dart';
import '../../ui/components/svg_btn_icon.dart';
import '../../core/ui_helper.dart';
import '../../ui/components/svg.dart';

class Quiz2Screen extends StatefulWidget {
  Quiz2Screen({Key? key}) : super(key: key);

  @override
  State<Quiz2Screen> createState() => _Quiz2ScreenState();
}

class _Quiz2ScreenState extends State<Quiz2Screen> {
  @override
  Widget build(BuildContext context) {
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
                                  'Landeskunde',
                                  style: Styles.bBold15,
                                ),
                                margin: EdgeInsets.only(right: 10))
                          ]),
                      vSpaceMedium,
                      cardWhite(context,
                          'Erwähnen Sie 10 Bundesländer in Deutschland!', ''),
                      vSpaceXSmall,
                      cardWhiteHeader(context, 1)
                    ]))));
  }

  Widget cardWhite(BuildContext context, String teks, String teks2) {
    var screenSizes = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          width: screenSizes.width - (screenSizes.width / 8),
          child: Column(children: <Widget>[
            Text(
              teks,
              style: Styles.bBold12,
              textAlign: TextAlign.center,
            ),
            (teks2.isNotEmpty)
                ? Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      teks2,
                      style: Styles.bBold12,
                      textAlign: TextAlign.left,
                    ))
                : Center()
          ]),
        ),
        Positioned(child: SVG.speakerIcon, left: -10, top: -30),
      ],
    );
  }

  Widget cardWhiteHeader(BuildContext context, int questionId) {
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
                            child: modalSheet(context)));
                  },
                ),
                SVGBtnIcon(
                  svg: SVG.nextIcon,
                  bgColor: green,
                  splashColor: Colors.teal,
                  onTap: () {},
                ),
              ],
            )),
      ]),
    ));
  }

  Widget modalSheet(BuildContext context) {
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
                    hintText: "isi jawaban",
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
