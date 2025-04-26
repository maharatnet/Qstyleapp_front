import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class ErrorComponent extends StatelessWidget {
  final Function? onTryAgainTap;
  final bool noInternetConnection;
  final bool withAnimation;

  const ErrorComponent({
    Key? key,
    @required this.onTryAgainTap,
    this.noInternetConnection = false,
    this.withAnimation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return noInternetConnection
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 180,
                child: OverflowBox(
                  minHeight: 220,
                 maxHeight:  220,
                  child: Center(
                    child: Lottie.asset(
                        'assets/animations/noInternet.json',
                        height: 220,
                        repeat: false),
                  ),
                ),
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    onTryAgainTap!();
                  },
                  child: Text(
                    'TryAgain',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              )
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              withAnimation
                  ? Center(
                      child: Column(
                        children: [
                          Lottie.asset(
                              'assets/animations/error.json',
                              height: 90,
                              fit: BoxFit.cover,
                              repeat: true),

                        ],
                      ),
                    )
                  : Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 35,
                    ),
              Text(
                'SomethingWentWrong',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  onTryAgainTap!();
                },
                child: Text(
                  'TryAgain',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              )
            ],
          );
  }
}
