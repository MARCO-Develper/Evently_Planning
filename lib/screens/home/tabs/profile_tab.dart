import 'package:evently/firebase/firebase_manager.dart';
import 'package:evently/login/login_screen.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: height * 0.22,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(64))),
        title: Container(
          margin: const EdgeInsets.only(top: 30),
          child: Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(1000),
                    bottomLeft: Radius.circular(1000),
                    bottomRight: Radius.circular(1000),
                  ),
                ),
                child: Image.asset(
                  "assets/images/route.png",
                  height: 135,
                  width: 135,
                ),
              ),
              SizedBox(
                width: width * 0.04,
              ),
              Container(
                height: 124,
                width: 221,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Marco Mina',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'marcomina.route@gmail.com',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Language", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border:
                    Border.all(width: 1, color: Theme.of(context).primaryColor),
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Arabic",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                  ImageIcon(
                    const AssetImage("assets/images/icons/Polygon 1.png"),
                    color: Theme.of(context).primaryColor,
                    size: 16,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text("Theme", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border:
                    Border.all(width: 1, color: Theme.of(context).primaryColor),
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Light",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                  ImageIcon(
                    const AssetImage("assets/images/icons/Polygon 1.png"),
                    color: Theme.of(context).primaryColor,
                    size: 16,
                  ),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                FirebaseManager.logOUt().then((_) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    LoginScreen.routeName,
                    (route) => false,
                  );
                });
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.04, vertical: height * 0.02),
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
              child: Row(
                children: [
                  ImageIcon(
                    const AssetImage("assets/images/icons/Exit.png"),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    size: 24,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Logout",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}
