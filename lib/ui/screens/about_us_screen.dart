import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../components/svg_btn_icon.dart';
import '../components/svg.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String content =
        '''Selamat datang di Denkschnell! Kami adalah tim yang berdedikasi dalam bidang bahasa, yang berfokus pada membantu Anda belajar bahasa Jerman dengan cara yang lebih mudah dan menyenangkan. Misi kami adalah membantu Anda meningkatkan keterampilan berbahasa Jerman, terutama dalam berbicara. Di Denkschnell, kami percaya bahwa berbicara adalah kunci utama dalam belajar bahasa. Oleh karena itu, kami telah mengembangkan aplikasi yang dirancang khusus untuk membantu Anda belajar bahasa Jerman melalui latihan interaktif dan berbasis praktik. Dengan Denkschnell, Anda dapat memperluas kosakata, memperbaiki tata bahasa, dan berlatih percakapan sehari-hari.
        
        Aplikasi kami menawarkan berbagai fitur untuk memperkaya pengalaman belajar bahasa Anda: latihan interaktif yang didasarkan pada situasi kehidupan sehari-hari, membantu Anda berbicara bahasa Jerman dengan lebih percaya diri; pembelajaran berbasis permainan yang membuat proses belajar menjadi menyenangkan dan menantang; fitur untuk berlatih berbicara dengan teman, tandem, dan mentor, memungkinkan Anda mendapatkan umpan balik langsung dan belajar bersama; serta akses offline sehingga Anda dapat menggunakan aplikasi ini kapan saja dan di mana saja, bahkan tanpa koneksi internet. Kami berkomitmen untuk menyediakan alat belajar yang praktis dan mudah diakses oleh semua orang. Denkschnell dirancang untuk membantu pemula dan mereka yang ingin meningkatkan keterampilan berbahasa Jerman dengan cara yang efektif dan efisien. Terima kasih telah memilih Denkschnell sebagai mitra belajar bahasa Jerman Anda. Selamat belajar dan semoga sukses!''';

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
                          child: Text(
                            content,
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
