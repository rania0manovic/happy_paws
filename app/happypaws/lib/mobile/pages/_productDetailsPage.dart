import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        picturesSection(),
        const Padding(
          padding:
              EdgeInsets.only(left: 34, right: 34, top: 10, bottom: 10),
          child: Text(
            "Aquariana tropical & temperate flake food",
            style: TextStyle(
                fontFamily: "GilroyLight",
                fontWeight: FontWeight.w300,
                fontSize: 20),
          ),
        ),
        const Padding(
          padding:
              EdgeInsets.only(left: 34, right: 34, top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$ 6.55",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
              ),
              Row(
                children: [
                  Image(
                    image: AssetImage("assets/images/star.png"),
                    height: 30,
                    width: 30,
                  ),
                  Image(
                    image: AssetImage("assets/images/star.png"),
                    height: 30,
                    width: 30,
                  ),
                  Image(
                    image: AssetImage("assets/images/star.png"),
                    height: 30,
                    width: 30,
                  ),
                  Image(
                    image: AssetImage("assets/images/star.png"),
                    height: 30,
                    width: 30,
                  ),
                  Image(
                    image: AssetImage("assets/images/star-half-empty.png"),
                    height: 30,
                    width: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Description(
              title: "Description", content: "This is some description"),
        ),
        actionsSection()
      ]),
    );
  }

  Padding actionsSection() {
    return Padding(
        padding: EdgeInsets.only(left: 34, right: 34, top: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 212,
              height: 48,
              decoration: BoxDecoration(
                  color: Color(0xff3F0D84),
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: Text(
                  "Buy now",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
            Container(
              height: 48,
              width: 48,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xff3F0D84),
                borderRadius: BorderRadius.circular(100)
              ),
                child: SvgPicture.asset(
              "assets/icons/cart.svg",
              color: Colors.white,
            )),
              Container(
              height: 48,
              width: 48,
              padding: EdgeInsets.all(0),
             
                child: SvgPicture.asset(
              "assets/icons/heart.svg",
              color: Color(0xff3F0D84),
            ))
          ],
        ),
      );
  }

  Column picturesSection() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 30, bottom: 30),
          child: Image(
            image: AssetImage("assets/images/fishfood1.jpg"),
            height: 250,
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 34, right: 34, top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: Color(0xff3F0D84),
                    borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/fishfood1.jpg',
                    fit: BoxFit.cover,
                    height: 47,
                    width: 47,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/fishfood2.jpg',
                  fit: BoxFit.cover,
                  height: 47,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/fishfood3.jpg',
                  fit: BoxFit.cover,
                  height: 47,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/fishfood4.jpg',
                  fit: BoxFit.cover,
                  height: 47,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/fishfood5.jpg',
                  fit: BoxFit.cover,
                  height: 47,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Description extends StatefulWidget {
  final String title;
  final String content;

  const Description({super.key, required this.title, required this.content});
  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF9F9F9),
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: Colors.grey.shade200,
          ),
          top: BorderSide(
            width: 2,
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 18,
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontFamily: "GilroyLight",
                  fontSize: 20,
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  isExpanded ? Icons.remove : Icons.add,
                  color: Color(0xff3F0D84),
                ),
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
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: "GilroyLight",
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
