import 'package:ai_radio/model/radio.dart';
import 'package:ai_radio/utils/ai_utils.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var radios = <MyRadio>[
    MyRadio(
        id: 1,
        order: 1,
        name: "91.1",
        tagline: "Rag Rag Mein Daude City",
        desc:
            "Radio City 91.1 is the first India's national private fm radio stations. It broadcasts in most of 40 cities on 91.1 FM and has 69 millions radio listeners",
        color: "0xffa11431",
        url: "https://prclive1.listenon.in/",
        category: "jazz",
        lang: "Hindi",
        image: "https://wallpapercave.com/wp/wp6971977.jpg",
        icon: "https://www.radiocity.in/assets/images/RC-logo-1.png")
  ];

  MyRadio _selectedRadio = MyRadio(
      id: 1,
      order: 1,
      name: "91.1",
      tagline: "Rag Rag Mein Daude City",
      desc:
          "Radio City 91.1 is the first India's national private fm radio stations. It broadcasts in most of 40 cities on 91.1 FM and has 69 millions radio listeners",
      color: "0xffa11431",
      url: "https://prclive1.listenon.in/",
      category: "jazz",
      lang: "Hindi",
      image: "https://wallpapercave.com/wp/wp6971977.jpg",
      icon: "https://www.radiocity.in/assets/images/RC-logo-1.png");

  bool _isplaying = false;
  final sugg = [
    "Can you help me",
    "Play",
    "Play rock music",
    "Stop",
    "What this app can do"
        "Pause",
    "Play 102 FM",
    "Play 107 Fm",
    "Play next",
    "Play pop music",
    "Play previous",
    "How old are you",
    "Who is your boss"
  ];

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    setupAlan();
    fetchRadios();

    _audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.playing) {
        _isplaying = true;
      } else {
        _isplaying = false;
      }
    });
  }

  setupAlan() {
    AlanVoice.addButton(
        "56748bff73c29c3006c90e303577884a2e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT);
    AlanVoice.callbacks.add((command) => _handleCommand(command.data));
  }

  _handleCommand(Map<String, dynamic> response) {
    switch (response["command"]) {
      case "play":
        _playMusic(_selectedRadio.url);
        break;

      case "play_channel":
        final id = response["id"];
        _audioPlayer.pause();
        MyRadio newRadio = radios.firstWhere((element) => element.id == id);
        radios.remove(newRadio);
        radios.insert(0, newRadio);
        _playMusic(newRadio.url);
        break;

      case "stop":
        _audioPlayer.stop();
        break;

      case "next":
        final index = _selectedRadio.id;
        MyRadio newRadio;
        if (index + 1 > radios.length) {
          newRadio = radios.firstWhere((element) => element.id == 1);
          radios.remove(newRadio);
          radios.insert(0, newRadio);
        } else {
          newRadio = radios.firstWhere((element) => element.id == index + 1);
          radios.remove(newRadio);
          radios.insert(0, newRadio);
        }
        _playMusic(newRadio.url);
        break;

      case "prev":
        final index = _selectedRadio.id;
        MyRadio newRadio;
        if (index - 1 <= 0) {
          newRadio = radios.firstWhere((element) => element.id == 1);
          radios.remove(newRadio);
          radios.insert(0, newRadio);
        } else {
          newRadio = radios.firstWhere((element) => element.id == index - 1);
          radios.remove(newRadio);
          radios.insert(0, newRadio);
        }
        _playMusic(newRadio.url);
        break;

      default:
        print("Command was ${response["command"]}");
        break;
    }
  }

  fetchRadios() async {
    final radioJson = await rootBundle.loadString("assets/radio.json");
    radios = MyRadioList.fromJson(radioJson).radios;
    print(radios);
    setState(() {});
  }

  _playMusic(String url) {
    _audioPlayer.play(UrlSource(url));
    _selectedRadio = radios.firstWhere((element) => element.url == url);
    print(_selectedRadio.name);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: AIColors.primaryColor1,
          child: [
            100.heightBox,
            "All Channels".text.xl4.white.semiBold.make().px16(),
            20.heightBox,
            ListView(
              padding: Vx.m0,
              shrinkWrap: true,
              children: radios
                  .map((e) => ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(e.icon),
                        ),
                        title: "${e.name} FM".text.white.make(),
                        subtitle: e.tagline.text.white.make(),
                      ))
                  .toList(),
            ).expand()
          ].vStack(crossAlignment: CrossAxisAlignment.start),
        ),
      ),
      body: Stack(
        // ignore: sort_child_properties_last
        children: [
          VxAnimatedBox()
              .size(context.screenWidth, context.screenHeight)
              .withGradient(
                LinearGradient(
                  colors: [AIColors.primaryColor1, AIColors.primaryColor2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              )
              .make(),
          [
            AppBar(
              title: "AI Radio".text.xl5.bold.color(Vx.black).make().shimmer(
                  primaryColor: Color.fromARGB(255, 243, 251, 253),
                  secondaryColor: Color.fromARGB(255, 202, 143, 195)),
              iconTheme: IconThemeData(color: Vx.white),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
            ).h(90).p16(),
            "Start with - Hey Alan 👇".text.italic.semiBold.white.make(),
            10.heightBox,
            VxSwiper.builder(
                itemCount: sugg.length,
                height: 50,
                viewportFraction: 0.35,
                autoPlay: true,
                autoPlayAnimationDuration: 3.seconds,
                autoPlayCurve: Curves.linear,
                enableInfiniteScroll: true,
                itemBuilder: (context, index) {
                  final s = sugg[index];
                  return Chip(
                    label: s.text.make(),
                    backgroundColor: Vx.randomColor,
                  );
                })
          ].vStack(),
          20.heightBox,
          radios != null
              ? VxSwiper.builder(
                  itemCount: radios.length,
                  aspectRatio: context.mdDeviceSize == MobileDeviceSize.small
                      ? 1.0
                      : context.mdDeviceSize == MobileDeviceSize.medium
                          ? 1.0
                          : context.mdDeviceSize == MobileDeviceSize.large
                              ? 1.0
                              : 3.0,
                  enlargeCenterPage: true,
                  onPageChanged: (index) {
                    _selectedRadio = radios[index];
                  },
                  itemBuilder: (context, index) {
                    final rad = radios[index];

                    return VxBox(
                            child: ZStack(
                      [
                        Positioned(
                          top: 0.0,
                          right: 0.0,
                          child: VxBox(
                                  child: rad.category.text.white.uppercase
                                      .make()
                                      .px16())
                              .height(40)
                              .black
                              .alignCenter
                              .withRounded(value: 10.0)
                              .make(),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: VStack([
                            rad.name.text.xl4.white.bold.make(),
                            rad.tagline.text.sm.semiBold.white.make()
                          ], crossAlignment: CrossAxisAlignment.center),
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: [
                              Icon(
                                CupertinoIcons.play_circle,
                                color: Colors.white,
                              ),
                              10.heightBox,
                              "Double tap to play".text.gray300.make()
                            ].vStack())
                      ],
                    ))
                        .clip(Clip.antiAlias)
                        .bgImage(DecorationImage(
                            image: NetworkImage(rad.image),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.3),
                                BlendMode.lighten)))
                        .border(color: Colors.black, width: 3.0)
                        .withRounded(value: 40.0)
                        .make()
                        .onInkDoubleTap(() {
                      _playMusic(rad.url);
                    }).p8();
                  },
                ).centered()
              : Center(
                  child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                )),
          Align(
            alignment: Alignment.bottomCenter,
            child: [
              if (_isplaying)
                "Playing Now - ${_selectedRadio.name} FM".text.white.make(),
              Icon(
                _isplaying
                    ? CupertinoIcons.stop_circle
                    : CupertinoIcons.play_circle,
                color: Colors.white,
                size: 50,
              ).onInkTap(() {
                if (_isplaying) {
                  _audioPlayer.stop();
                } else {
                  _playMusic(_selectedRadio.url);
                }
              })
            ].vStack(),
          ).pOnly(bottom: context.percentHeight * 12)
        ],
        fit: StackFit.expand,
        clipBehavior: Clip.antiAlias,
      ),
    );
  }
}
