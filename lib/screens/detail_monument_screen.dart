import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:escucha_tu_historia/generated/l10n.dart';
import 'package:escucha_tu_historia/providers/monuments_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/audio_provider.dart';
import '../providers/settings_provider.dart';

class DetailMonumentScreen extends StatelessWidget {
  const DetailMonumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final settingProvider = Provider.of<SettingsProvider>(context);
    final monumentsProvider = Provider.of<MonumentsProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: monumentsProvider.selectedMonument == null
            ? Center(
                child: SizedBox(
                  width: size.width * 0.2,
                  height: size.width * 0.2,
                  child: const CircularProgressIndicator(
                    backgroundColor: Colors.black38,
                    strokeWidth: 6,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                ),
              )
            : Column(
                children: [
                  ImageTitleWidget(size: size),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: size.height * 0.33,
                    child: DescriptionWidget(size: size),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: AudioWidget(
                        size: size, settingProvider: settingProvider),
                  ),
                ],
              ),
      ),
    );
  }
}

class NextBackMonument extends StatelessWidget {
  const NextBackMonument({
    super.key,
    required this.size,
    required this.text,
    required this.onPressed,
  });

  final Size size;
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.05,
      width: size.width * 0.25,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff036242),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: size.width * 0.03),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

//Widget que controla el tema del audio
class AudioWidget extends StatelessWidget {
  const AudioWidget({
    super.key,
    required this.size,
    required this.settingProvider,
  });

  final Size size;
  final SettingsProvider settingProvider;

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);
    final monumentsProvider = Provider.of<MonumentsProvider>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      audioProvider.setUrl(monumentsProvider.selectedMonument!.audioUrl!);
    });
    return Container(
      width: size.width,
      height: size.height * 0.14,
      decoration: BoxDecoration(
        color: settingProvider.darkMode
            ? const Color(0xff012d21)
            : const Color(0xff6aebb1),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinePlayBarWidget(size: size, audioProvider: audioProvider),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NextBackMonument(
                size: size,
                text: S.current.previous_monument,
                onPressed: !monumentsProvider.thereIsPreviousMonument(
                        monumentsProvider.selectedMonument!.number!)
                    ? null
                    : () {
                        audioProvider.pause(true);
                        monumentsProvider.getPreviousMonument(
                            monumentsProvider.selectedMonument!.number!);

                        context.replace('/monumentDetail');
                      },
              ),
              AudioControlPlayWidget(audioProvider: audioProvider),
              NextBackMonument(
                size: size,
                text: S.current.next_monument,
                onPressed: !monumentsProvider.thereIsNextMonument(
                        monumentsProvider.selectedMonument!.number!)
                    ? null
                    : () {
                        audioProvider.pause(true);
                        monumentsProvider.getNextMonument(
                            monumentsProvider.selectedMonument!.number!);
                        context.replace('/monumentDetail');
                      },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LinePlayBarWidget extends StatelessWidget {
  const LinePlayBarWidget({
    super.key,
    required this.size,
    required this.audioProvider,
  });

  final Size size;
  final AudioProvider audioProvider;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 20),
        Expanded(
          child: ProgressBar(
            progress: audioProvider.currentPosition,
            total: audioProvider.totalDuration,
            onSeek: (value) {
              audioProvider.seekToSec(value);
            },
            timeLabelLocation: TimeLabelLocation.sides,
            barHeight: 4,
            baseBarColor: Colors.grey[700],
            progressBarColor: Colors.white,
            thumbColor: Colors.white,
            bufferedBarColor: Colors.grey[500],
            timeLabelTextStyle: TextStyle(
              color: Colors.white,
              fontSize: size.width * 0.033,
            ),
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}

class AudioControlPlayWidget extends StatelessWidget {
  const AudioControlPlayWidget({
    super.key,
    required this.audioProvider,
  });

  final AudioProvider audioProvider;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            //font awesome icon volver haca atras 5 segundos
            FontAwesomeIcons.arrowRotateLeft,
            size: size.width * 0.04,

            color: Colors.white,
          ),
          onPressed: () {
            audioProvider.substractTime();
          },
        ),
        IconButton(
          icon: Icon(
            audioProvider.isPlaying
                ? FontAwesomeIcons.pause
                : FontAwesomeIcons.play,
            // FontAwesomeIcons.pause,
            color: Colors.white,
            size: size.width * 0.04,
          ),
          onPressed: () {
            if (audioProvider.isPlaying) {
              audioProvider.pause(false);
            } else {
              audioProvider.play();
            }
          },
        ),
        IconButton(
          icon: Icon(
            //font awesome icon hacia delante 5 segundos
            FontAwesomeIcons.arrowRotateRight,
            size: size.width * 0.04,

            color: Colors.white,
          ),
          onPressed: () {
            audioProvider.addTime();
          },
        ),
      ],
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final monumentsProvider = Provider.of<MonumentsProvider>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            height: size.height * 0.29,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: monumentsProvider.selectedMonument!.text!
                      .split('\n')
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            e,
                            style: TextStyle(
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.normal,
                              color:
                                  Theme.of(context).textTheme.bodyLarge?.color,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          S.current.scroll_to_see,
          style: TextStyle(
            fontSize: size.width * 0.027,
            color: Colors.grey, // Puedes ajustar el color según el tema
          ),
        ),
      ],
    );
  }
}

class ImageTitleWidget extends StatelessWidget {
  const ImageTitleWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);
    final settingProvider = Provider.of<SettingsProvider>(context);
    final monumentsProvider = Provider.of<MonumentsProvider>(context);
    return SizedBox(
      height: size.height * 0.45,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            top: size.height * 0.09,
            child: SizedBox(
              width: size.width,
              height: size.height * 0.3,
              child: CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 1.0,
                  pageSnapping: true,
                  enlargeCenterPage: false,
                  enableInfiniteScroll: true,
                  autoPlay: false,
                  scrollDirection: Axis.horizontal,
                ),
                items: monumentsProvider.selectedMonument!.imagesUrls!
                    .map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                        ),
                        child: FadeInImage(
                          placeholder:
                              const AssetImage('assets/images/loading.gif'),
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ),

          Positioned(
            bottom: size.height * 0.03,
            left: size.width * 0.03,
            child: Container(
              width: size.width * 0.7,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                monumentsProvider.selectedMonument!.name!,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.062,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // subtitle

          monumentsProvider.selectedMonument!.subtittle != null
              ? Positioned(
                  bottom: size.height * 0.001,
                  left: size.width * 0.09,
                  child: Text(
                    '"${monumentsProvider.selectedMonument!.subtittle}"',
                    style: TextStyle(
                      fontSize: size.width * 0.035,
                      color: settingProvider.darkMode
                          ? const Color(0xff6aebb1)
                          : const Color(0xff046343),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              : Container(),

          // icono del numero monumento
          Positioned(
            bottom: size.height * 0.03,
            right: size.width * 0.033,
            child: Container(
              width: size.width * 0.15,
              height: size.width * 0.15,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                // este hexadecimal de color 012d21
                color: const Color(0xff036242),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  monumentsProvider.selectedMonument!.number!.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.06,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: size.height * 0.03,
            left: size.width * 0.03,
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                audioProvider.pause(true);
                settingProvider.isHomeScreen
                    ? context.go('/home')
                    : context.pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.arrowLeftLong,
                        size: size.width * 0.08),
                    const SizedBox(width: 10),
                    Text(
                      S.current.back,
                      style: TextStyle(
                        fontSize: size.width * 0.05,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: size.height * 0.06,
            right: size.width * 0.033,
            child: GestureDetector(
              onTap: () async {
                final Uri url = Uri.parse(
                    'https://www.google.com/maps?q=${monumentsProvider.selectedMonument!.location?.lat},${monumentsProvider.selectedMonument!.location?.lon}');
                launchUrl(url);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff036242),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                        size: size.width * 0.07,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        S.current.how_to_get,
                        style: TextStyle(
                          fontSize: size.width * 0.05,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
