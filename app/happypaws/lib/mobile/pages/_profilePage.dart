import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/routes/app_router.gr.dart';
import 'package:happypaws/common/services/AuthService.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late dynamic user=Null;
  late dynamic formatedCardNumber=Null;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    var fetchedUser = await AuthService().getCurrentUser();
    formatCard(fetchedUser?['MyPawNumber']);
    setState(() {
      user = fetchedUser;
    });
  }

  void formatCard(String cardNumber) {
    List<String> chunks = [];
    for (int i = 0; i < cardNumber.length; i += 4) {
      int end = i + 4;
      if (end > cardNumber.length) {
        end = cardNumber.length;
      }
      chunks.add(cardNumber.substring(i, end));
    }
    setState(() {
      formatedCardNumber = chunks.join('  ');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            user != Null ? myPawCard() : CircularProgressIndicator(),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              height: 220,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () =>
                          context.router.push(const PersonalInformationRoute()),
                      child: const Text(
                        "Personal Information",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'GilroyLight',
                            fontSize: 20),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.router.push(const MyPetsRoute()),
                      child: const Text(
                        "My Pets",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'GilroyLight',
                            fontSize: 20),
                      ),
                    ),
                    GestureDetector(
                      child: const Text(
                        "Payment Information",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'GilroyLight',
                            fontSize: 20),
                      ),
                    )
                  ]),
            )
          ]),
        ),
        logOutButton()
      ],
    );
  }

  Positioned logOutButton() {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: GestureDetector(
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xff3F0D84)),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 0, left: 0),
                child: Text(
                  "Log out",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Center myPawCard() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
        child: Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: AssetImage(
                  'assets/images/card.png'), 
              fit: BoxFit.cover, 
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "MyPaw",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
                const Spacer(),
                Text(
                  user['FirstName'] + ' ' + user['LastName'],
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  formatedCardNumber!= Null ? formatedCardNumber : '',
                  style: const TextStyle(color: Colors.white, fontSize: 28),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
