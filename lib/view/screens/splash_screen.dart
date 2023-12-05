import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_weather_app/constants/style.dart';
import 'package:open_weather_app/view/widgets/custom_loading.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      context.go('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    //initializing device size
    size = MediaQuery.sizeOf(context);

//initializing text theme
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            const Spacer(
              flex: 2,
            ),
            Card(
              elevation: 1,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: EdgeInsets.all(size.width * .05),
                child: Column(
                  children: <Widget>[
                    //App Image for the assets/image
                    Image.asset(
                      'assets/images/app_logo.png',
                      width: size.width * .4,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    //text appName
                    Text(
                      appName,
                      style: textTheme.headlineSmall?.copyWith(
                          fontFamily: GoogleFonts.robotoMono().fontFamily,
                          letterSpacing: 0.5),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            //custom loading animation
            const CustomLoading(),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
