import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../components/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSizes = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: lightblue,
        body: Center(
            child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              decoration: BoxDecoration(
                  color: lightbrown,
                  borderRadius: BorderRadius.all(Radius.circular(45)),
                  border: Border.all(color: black, width: 2)),
              width: (screenSizes.width / 2) + screenSizes.width / 3,
              child: Text(
                '''Selamat datang di Denkschnell! Aplikasi ini dirancang untuk membantu Anda meningkatkan keterampilan berbicara dalam bahasa Jerman dengan cara yang interaktif dan menyenangkan.
Untuk hasil terbaik, kami sarankan Anda memainkan Denkschnell secara tandem atau berpasangan. Belajar dengan mitra akan membuat latihan lebih efektif dan menyenangkan, serta memberikan kesempatan untuk mempraktikkan percakapan nyata.
Terima kasih telah memilih Denkschnell. Selamat belajar dan semoga sukses!''',
                style: Styles.bRegular12,
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(child: SVG.quotes1Icon, left: 10, top: -5),
            Positioned(child: SVG.quotes2Icon, right: 10, bottom: -5),
          ],
        )));
  }
}
