import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'svg_btn_icon.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';
import '../../providers/helpers/audio_provider.dart';
import '../../providers/helpers/backsound_provider.dart';

class ModalSheet extends StatefulWidget {
  final String teksAudio;
  const ModalSheet({super.key, required this.teksAudio});

  @override
  State<ModalSheet> createState() => _ModalSheetState();
}

class _ModalSheetState extends State<ModalSheet> {
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
    final aProvider = Provider.of<AudioProvider>(context);
    final bsProvider = Provider.of<BacksoundProvider>(context);
    return Container(
      padding: const EdgeInsets.all(20),
      constraints: const BoxConstraints(
        minHeight: 180,
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('  Play audio', style: Styles.gBold15),
            vSpaceSmall,
            Container(
                padding: const EdgeInsets.all(5),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: greyv2, width: 2),
                    borderRadius: BorderRadius.circular(50)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          widget.teksAudio,
                          style: const TextStyle(
                              color: greyv2, fontWeight: FontWeight.normal),
                        )),
                    SVGBtnIcon(
                        svg: Icon(
                          (!aProvider.onPlay) ? Icons.play_arrow : Icons.pause,
                          color: Colors.white,
                          size: 30,
                        ),
                        bgColor: green,
                        onTap: () async {
                          aProvider.setSource("audios/${widget.teksAudio}.mp3");
                          if (!aProvider.onPlay) {
                            if (bsProvider.isPlaying) {
                              await bsProvider.stopAudio();
                            }
                            await aProvider.play();
                          } else {
                            aProvider.pause();
                          }
                        },
                        splashColor: Colors.teal)
                  ],
                )),
            vSpaceSmall,
          ]),
    );
  }
}
