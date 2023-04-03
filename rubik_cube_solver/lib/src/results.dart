import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Results extends StatelessWidget {
  String? sol;
  Results({super.key, this.sol});

  @override
  Widget build(BuildContext context) {
    List<String> imagePathList() {
      List<String> imgList = [];
      String str = sol!;
      List<String> strarray = str.split(" ");

      for (var i = 0; i < strarray.length; i++) {
        var position = strarray[i];

        switch (position) {
          case "U":
            {
              imgList.add("assets/images/U.png");
            }
            break;
          case "U'":
            {
              imgList.add("assets/images/U'.png");
            }
            break;
          case "L":
            {
              imgList.add("assets/images/L.png");
            }
            break;
          case "L'":
            {
              imgList.add("assets/images/L'.png");
            }
            break;
          case "F":
            {
              imgList.add("assets/images/F.png");
            }
            break;
          case "F'":
            {
              imgList.add("assets/images/F'.png");
            }
            break;
          case "D":
            {
              imgList.add("assets/images/D.png");
            }
            break;
          case "D'":
            {
              imgList.add("assets/images/D'.png");
            }
            break;
          case "R":
            {
              imgList.add("assets/images/R.png");
            }
            break;
          case "R'":
            {
              imgList.add("assets/images/R'.png");
            }
            break;
          case "B":
            {
              imgList.add("assets/images/B.png");
            }
            break;
          case "B'":
            {
              imgList.add("assets/images/B'.png");
            }
            break;
          default:
            {
              imgList.add("assets/images/B.png");
            }
            break;
        }
      }
      return imgList;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Final Results'),
        leading: BackButton(
          onPressed: () => '/firstView',
        ),
      ),
      body: ListView(
        children: [
          const Text(
            "White on top, Orange in front",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Builder(
            builder: (context) {
              final double height = MediaQuery.of(context).size.height;
              return CarouselSlider(
                options: CarouselOptions(
                  height: height,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  autoPlay: true,
                ),
                items: imagePathList()
                    .map((item) => Container(
                      margin: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        child: Stack(
                          children: <Widget>[
                            Image.asset(item,
                                fit: BoxFit.cover, width: 1000.0),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(200, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0)
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
