import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/generated/L10n.dart';
// import '../common/app_config.dart' as config;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Helper.whiteColor,
      body: Padding(
          padding:
              const EdgeInsets.only(top: 57.0, left: 16, right: 16, bottom: 65),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => SystemNavigator.pop(),
                  padding: EdgeInsets.only(left: 7),
                  icon: const Icon(Icons.clear, color: Helper.closeIconColor),
                  iconSize: 16,
                ),
              ),
              const SizedBox(
                height: 98,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: Trans.of(context).login_content,
                      style: TextStyle(
                          color:Helper.titleColor,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                          fontSize: 20.0)),
                  TextSpan(
                      text: "\n",
                      style: TextStyle(
                          color: Helper.whiteColor,
                          fontWeight: FontWeight.bold,
                          height: 18,
                          fontSize: 10)),
                  TextSpan(
                      text: Trans.of(context).lets_start_with_login,
                      style: TextStyle(
                          color: Helper.blackColor,
                          fontWeight: FontWeight.w400,
                          height: 1.3,
                          fontSize: 16.0)),
                ]),
              ),
              const SizedBox(
                height: 64,
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: [
                    LoginButton(
                      name: Trans.of(context).email,
                      icon: Icons.email_outlined,
                      event: 'email',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    LoginButton(
                      name: "Apple" + Trans.of(context).continues,
                      icon: Icons.apple,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TwitterButton(
                        name: "Twitter" + Trans.of(context).continues,
                        icon: Icons.man),
                    const SizedBox(
                      height: 15,
                    ),
                    LoginButton(
                        name: "Facebook" + Trans.of(context).continues,
                        icon: Icons.facebook,
                        color: Colors.blue)
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(Trans.of(context).i_forgot_password),
                      SizedBox(
                        width: 8,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/Signup");
                          },
                          child: Text(
                            Trans.of(context).register,
                            style:
                                defaultTextStyle(Colors.blue, FontWeight.bold),
                          ))
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class LoginButton extends StatelessWidget {
  String event;
  String name;
  IconData icon;
  MaterialColor? color;
  LoginButton(
      {Key? key,
      required this.name,
      required this.icon,
      this.color,
      this.event = "default"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Helper.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 12, bottom: 11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color ?? Helper.blackColor,
              size: 30,
            ),
            Text(
              "   " + name,
              style: defaultTextStyle(Helper.blackColor, FontWeight.w700, size: 14),
            ),
          ],
        ),
      ),
      onPressed: () {
        if (event == "email")
          Navigator.of(context).pushNamed("/EmailLogin");
      },
    );
  }
}

class TwitterButton extends StatelessWidget {
  String name;
  IconData icon;
  MaterialColor? color;
  TwitterButton({Key? key, required this.name, required this.icon, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Helper.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 12, bottom: 11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "images/twitter.svg",
              width: 24,
              height: 19,
            ),
            Text(
              "   " + name,
              style: defaultTextStyle(Helper.blackColor, FontWeight.w700, size: 14),
            ),
          ],
        ),
      ),
      onPressed: () {},
    );
  }
}
