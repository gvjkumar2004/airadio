import 'package:airadio/utils/ai_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:matcher/matcher.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/radio.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MyRadio> radios;

  @override
  void initState() {
    super.initState();
    fetchRadios();
  }

  fetchRadios() async {
    final radioJson = await rootBundle.loadString("assets/radio.json");
    radios = MyRadioList.fromJson(radioJson).radios;
    print(radios);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: Stack(
        children: [
          VxAnimatedBox()
              .size(context.screenWidth, context.screenHeight)
              .withGradient(LinearGradient(
                  colors: [AIcolors.primaryColor1, AIcolors.primaryColor2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight))
              .make(),
          AppBar(
            title: "AI Radio".text.xl4.bold.white.make().shimmer(
                primaryColor: Vx.purple300, secondaryColor: Colors.white),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          ).h(100.0).p(16.0),
          if (radios.isNotEmpty)
            VxSwiper.builder(
                itemCount: radios.length,
                itemBuilder: (context, index) {
                  final rad = radios[index];

                  return VxBox(child: ZStack([]))
                      .bgImage(DecorationImage(image: NetworkImage(rad.image)))
                      .make();
                })
          else
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
