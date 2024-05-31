import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';
import '../components/card_custom.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget build(BuildContext context) {
    String content =
        '''Selamat datang di Denkschnell! Aplikasi ini dirancang untuk membantu Anda meningkatkan keterampilan berbicara dalam bahasa Jerman dengan cara yang interaktif dan menyenangkan.
Untuk hasil terbaik, kami sarankan Anda memainkan Denkschnell secara tandem atau berpasangan. Belajar dengan mitra akan membuat latihan lebih efektif dan menyenangkan, serta memberikan kesempatan untuk mempraktikkan percakapan nyata.
Terima kasih telah memilih Denkschnell. Selamat belajar dan semoga sukses!''';

    return Scaffold(
        backgroundColor: lightblue,
        body: SafeArea(
            child: CardCustom(
          parentContext: context,
          teks: content,
        )));
  }
}
