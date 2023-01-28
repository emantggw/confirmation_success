import 'dart:async';

import 'package:confirmation_success/confirmation_success.dart';
import 'package:flutter/material.dart';

class ParkingConfirmedScreen extends StatefulWidget {
  @override
  State<ParkingConfirmedScreen> createState() => _ParkingConfirmedScreenState();
}

class _ParkingConfirmedScreenState extends State<ParkingConfirmedScreen> {
  Color yellow = const Color(0xFFFDC435);
  Color black = const Color.fromARGB(255, 36, 35, 35);
  Color white = const Color.fromARGB(179, 190, 179, 179);
  StreamSubscription<void>? _sub;
  bool isSuccess = false;
  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   _sub = _navigateAfter().asStream().listen((event) {});
    // });
    super.initState();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  Future<void> _navigateAfter() async {
    if (mounted) {
      await Future.delayed(const Duration(seconds: 15), navigateToHome);
    }
  }

  Future<bool> navigateToHome() async {
    // Navigator.of(context).pushAndRemoveUntil(
    //   MaterialPageRoute(
    //     builder: (context) => HomeScreen(
    //       selectedIndex: 0,
    //     ),
    //   ),
    //   (Route<dynamic> route) => false,
    // );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: navigateToHome,
      child: Scaffold(
        backgroundColor: black,
        floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width * 0.55,
          child: FloatingActionButton.extended(
              backgroundColor: const Color.fromARGB(255, 53, 50, 50),
              onPressed: navigateToHome,
              label: Text(
                "OKAY",
                style: TextStyle(color: yellow, fontSize: 16),
              )),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              leading: GestureDetector(
                onTap: navigateToHome,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: yellow,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height / 2 -
                      2 * kToolbarHeight -
                      120),
            ),
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConfirmationSuccess(
                      reactColor: yellow,
                      bubbleColors: [yellow],
                      numofBubbles: 35,
                      maxBubbleRadius: 8,
                      child: const Text("VOILA!",
                          style: TextStyle(color: Colors.black, fontSize: 18))),
                  const SizedBox(
                    height: 40,
                  ),
                  const Divider(
                    height: 2,
                    color: Color.fromARGB(179, 55, 51, 51),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Text(
                          "We've recived your order!",
                          style: TextStyle(
                            color: white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  const Divider(
                    height: 2,
                    color: Color.fromARGB(179, 55, 51, 51),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
