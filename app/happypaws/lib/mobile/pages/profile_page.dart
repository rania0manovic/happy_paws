import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/desktop/components/spinner.dart';
import 'package:happypaws/routes/app_router.gr.dart';
import 'package:happypaws/common/services/AuthService.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late dynamic user = Null;
  late dynamic formatedCardNumber = Null;

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
        RefreshIndicator(
          onRefresh: () async => await fetchUser(),
          child: ListView(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              user != Null ? myPawCard() : const Spinner(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        height: 1,
                        color: AppColors.gray.withOpacity(0.2),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: () => context.router
                              .push(const PersonalInformationRoute()),
                          child: const Text(
                            "Personal Information",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        height: 1,
                        color: AppColors.gray.withOpacity(0.2),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: () => context.router
                              .push(MyPetsRoute(userId: user?['Id'])),
                          child: const Text(
                            "My Pets",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        height: 1,
                        color: AppColors.gray.withOpacity(0.2),
                      ),
                    ]),
              )
            ]),
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
        onTap: () {
          AuthService().logOut();
          context.router.push(const WelcomeRoute());
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primary),
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
                      fontWeight: FontWeight.w700,
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
              image: AssetImage('assets/images/card.png'),
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
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    )
                  ],
                ),
                const Spacer(),
                Text(
                  user['FirstName'] + ' ' + user['LastName'],
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  formatedCardNumber != Null ? formatedCardNumber : '',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
