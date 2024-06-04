import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../components/svg_btn_icon.dart';
import '../components/svg.dart';
import '../../providers/helpers/database_helper.dart';

class AboutUsScreen extends StatefulWidget {
  AboutUsScreen({Key? key}) : super(key: key);

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
                                    Navigator.pushNamed(
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
                                  'Tentang Kami',
                                  style: Styles.bBold15,
                                ),
                                margin: EdgeInsets.only(right: 10))
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
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        child: Image.asset(
                                            'assets/images/spiral.png'),
                                        height: 35,
                                        width: 35,
                                      ))))),
                      vSpaceSmall,
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: _isLoading
                              ? CircularProgressIndicator(color: darkblue)
                              : abouts!.isEmpty
                                  ? Text('...')
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
                      Text('Denkschnell', style: Styles.xsLabelTxtStyle)
                    ]))));
  }
}
