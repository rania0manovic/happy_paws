import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        CircularPhotoLayout(),
        const Padding(
          padding: EdgeInsets.only(left: 45, right: 45),
          child: Text(
            "Our primary goal is to help as many animals as we can by providing top quality care.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
        ),
        _cheritySection(),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image(
                  width: MediaQuery.of(context).size.width,
                  image: const AssetImage("assets/images/question_section.jpg"),
                  fit: BoxFit.contain),
            ),
            const QuestionSectionItem(
              title: "Why Happy Paws?",
              content:
                  "At our establishment, we pride ourselves on offering an unparalleled array of pet essentials, ensuring that every need of your beloved companion is met with utmost care and dedication. Our esteemed shop proudly showcases an exquisite selection of top-quality nourishment, surpassing what ordinary stores can provide. Moreover, our exceptional team comprises meticulously handpicked doctors who possess extensive expertise and years of invaluable experience in the realm of animal care.",
            ),
            const QuestionSectionItem(
                title: "Can I make a reservation online?", content: ""),
            const QuestionSectionItem(
                title: "Can I order products online?", content: ""),
            const QuestionSectionItem(
                title:
                    "What if the date of the appointment isn’t convenient for me?",
                content: ""),
            const QuestionSectionItem(
                title: "What if my pet needs assistance urgently?",
                content: ""),
            const QuestionSectionItem(
                title: "What is MyPaw card used for?", content: "")
          ],
        )
      ]),
    );
  }
}

Column _cheritySection() {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 30, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Image(
              height: 140,
              width: 140,
              image: AssetImage("assets/images/charity.jpg"),
              fit: BoxFit.contain,
            ),
            Container(
              width: 180,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff3F0D84)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 0, left: 0),
                    child: Text(
                      "Donate now",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  SvgPicture.asset(
                    "assets/icons/long_right_arrow.svg",
                    height: 40,
                    width: 40,
                    color: Colors.white,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      const Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Text(
          "Each month, we diligently dispatch packages containing essential food and necessities to animal shelters that are most profoundly in need of our assistance. Should you desire to contribute towards our noble cause of ensuring the well-being and contentment of these innocent creatures, we kindly urge you to make a donation today.",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
      ),
    ],
  );
}

class CircularPhotoLayout extends StatefulWidget {
  @override
  State<CircularPhotoLayout> createState() => _CircularPhotoLayoutState();
}

class _CircularPhotoLayoutState extends State<CircularPhotoLayout> {
  @override
  Widget build(BuildContext context) {
    var photoUrl = "assets/images/photo_1.jpg";
    void alterPhotoUrl(index) {
      setState(() {
        photoUrl = "assets/images/photo_$index.jpg";
      });
    }

    const centralPhotoSize =
        162.0;
    const smallPhotoSize =
        73.0;
    final centralPhotoPosition = Offset(
      MediaQuery.of(context).size.width / 2,
      180,
    ); 
    const circleRadius = 130; 
    List<Widget> smallPhotos = List.generate(8, (index) {
      final angle = (2 * pi / 8) * index;
      final x = centralPhotoPosition.dx + cos(angle) * circleRadius;
      final y = centralPhotoPosition.dy + sin(angle) * circleRadius;
      final adjustedIndex = index + 1;
      final opacity = adjustedIndex == 1 ? 1.0 : 0.5;

      return Positioned(
        top: y - smallPhotoSize / 2,
        left: x - smallPhotoSize / 2,
        child: Opacity(
            opacity: opacity,
            child: GestureDetector(
              onTap: () => {alterPhotoUrl(adjustedIndex), print(index)},
              child: Container(
                width: smallPhotoSize,
                height: smallPhotoSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/photo_$adjustedIndex.jpg'), 
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )),
      );
    });

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 380,
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            top: centralPhotoPosition.dy - centralPhotoSize / 2,
            left: centralPhotoPosition.dx - centralPhotoSize / 2,
            child: CentralPhoto(photoUrl: photoUrl),
          ),
          ...smallPhotos,
        ],
      ),
    );
  }

  DecorationImage createDecorationImage(String imageUrl) {
    return DecorationImage(
      image: AssetImage(imageUrl),
      fit: BoxFit.cover,
    );
  }
}

class QuestionSectionItem extends StatefulWidget {
  final String title;
  final String content;

  const QuestionSectionItem(
      {super.key, required this.title, required this.content});
  @override
  _QuestionSectionItemState createState() => _QuestionSectionItemState();
}

class _QuestionSectionItemState extends State<QuestionSectionItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            trailing: IconButton(
              icon: Icon(isExpanded ? Icons.remove : Icons.add),
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Text(
                widget.content,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
        ],
      ),
    );
  }
}

class CentralPhoto extends StatefulWidget {
  final String photoUrl;

  CentralPhoto({required this.photoUrl});

  @override
  _CentralPhotoState createState() => _CentralPhotoState();
}

class _CentralPhotoState extends State<CentralPhoto> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 162,
      height: 162,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
        image: DecorationImage(
          image: AssetImage(widget.photoUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
