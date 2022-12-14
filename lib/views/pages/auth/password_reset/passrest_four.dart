import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/generated/l10n.dart';
import 'package:laxia/views/pages/auth/emaillogin.dart';
import 'package:laxia/views/pages/auth/login.dart';
// import '../common/app_config.dart' as config;

class PassRest_Four extends StatefulWidget {
  const PassRest_Four({Key? key}) : super(key: key);

  @override
  _PassRest_FourState createState() => _PassRest_FourState();
}

class _PassRest_FourState extends State<PassRest_Four> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Helper.whiteColor,
      body: Padding(
          padding: const EdgeInsets.only(top: 124.42),
          child: Column(
            children: <Widget>[
              Center(
                  child: SvgPicture.asset(
                "assets/images/check_mail.svg",
                width: 54.17,
                height: 54.17,
                color: Helper.mainColor,
              )),
              SizedBox(
                height: 25.42,
              ),
              Center(
                  child: Text(Trans.of(context).complete_reset,
                      style: defaultTextStyle(Helper.mainColor, FontWeight.w700,
                          size: 18))),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(Trans.of(context).reset_password_end,
                      style: TextStyle(
                          color: Helper.maintxtColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          height: 1.5))),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 77, right: 77),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Helper.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    splashFactory: NoSplash.splashFactory,
                    shadowColor: Colors.transparent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 14, bottom: 14),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            Trans.of(context).login,
                            style: TextStyle(
                                color: Helper.whiteColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                ),
              ),
            ],
          )),
    );
  }
}
