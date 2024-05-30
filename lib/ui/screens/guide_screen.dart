import 'package:flutter/material.dart';
import '../../core/styles.dart';
import '../../ui/components/svg_btn_icon.dart';
import '../../core/ui_helper.dart';
import '../../ui/components/svg.dart';
import '../../ui/components/card_custom.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String content = '''
    Permainan ini melibatkan dua orang: satu sebagai pemberi soal dan satu lagi sebagai penjawab soal. 
Pemberi soal akan menyebutkan soal dan pilihan jawabannya. 
Penjawab soal harus segera memilih jawaban yang dianggap benar dan cepat. 
Jika jawabannya benar, pemberi soal menekan tombol "Benar". Jika salah, tombol "Salah" ditekan, lalu hitunglah jumlah benarnya dan sampaikanlah kepada temanmu.
Terdapat 5 soal, pemain dapat memilih untuk melanjutkan dengan menekan tombol "Lanjut" atau berhenti dengan menekan tombol "Home".
  ''';
    return Scaffold(
        backgroundColor: lightblue,
        body: SingleChildScrollView(
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
                              onTap: () {},
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
                            margin: EdgeInsets.only(right: 20))
                      ]),
                  Image.asset('assets/images/menu-building.png',
                      width: 60, height: 60),
                  vSpaceSmall,
                  Text('Petunjuk Penggunaan', style: Styles.titleBarStyle),
                  vSpaceSmall,
                  CardCustom(parentContext: context, teks: content),
                  vSpaceSmall,
                  SVGBtnIcon(
                      svg: SVG.nextIcon,
                      bgColor: green,
                      onTap: () {},
                      splashColor: Colors.teal),
                  vSpaceSmall,
                  Text('Denkschnell', style: Styles.sLabelTxtStyle)
                ]))));
  }
}
