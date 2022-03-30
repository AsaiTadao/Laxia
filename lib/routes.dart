import 'package:flutter/material.dart';
import 'package:laxia/models/m_message.dart';
import 'package:laxia/views/pages/main/appointment/chatScreen.dart';
import 'package:laxia/views/pages/auth/password_reset/passrest_four.dart';
import 'package:laxia/views/pages/auth/password_reset/passrest_one.dart';
import 'package:laxia/views/pages/auth/password_reset/passrest_three.dart';
import 'package:laxia/views/pages/auth/registration.dart';
import 'package:laxia/views/pages/main/favorite/favorite.dart';
import 'package:laxia/views/pages/main/home/narrow_case.dart';
import 'package:laxia/views/pages/main/home/narrow_diary.dart';
// import 'package:laxia/views/pages/main/home/search/searchview.dart';
import 'package:laxia/views/pages/main/home/selectprefecture.dart';
import 'package:laxia/views/pages/main/home/selectsurgery.dart';
import 'package:laxia/views/pages/main/mypage/mypage.dart';
import 'package:laxia/views/pages/auth/emaillogin.dart';
import 'package:laxia/views/pages/auth/login.dart';
import 'package:laxia/views/dashboard.dart';
import 'package:laxia/views/pages/main/appointment/appointment.dart';
import 'package:laxia/views/pages/main/home/home.dart';
import 'package:laxia/views/onboarding.dart';
import 'package:laxia/views/pages/auth/signup.dart';
import 'package:laxia/views/pages/main/reservation/completion.dart';
import 'package:laxia/views/pages/main/reservation/confirmation.dart';
import 'package:laxia/views/pages/main/reservation/reservation.dart';
import 'package:laxia/views/pages/main/contribution/diary_list.dart';
import 'package:laxia/views/pages/main/contribution/diary_add_step1.dart';
import 'package:laxia/views/pages/main/contribution/diary_add_step2.dart';
import 'package:laxia/views/pages/main/contribution/diary_add_step3.dart';
import 'package:laxia/views/pages/main/contribution/diary_add_step4.dart';
import 'package:laxia/views/pages/main/contribution/diary_add_step5.dart';
import 'package:laxia/views/pages/main/contribution/diary_add_progress.dart';
import 'package:laxia/views/pages/main/contribution/counsel_list.dart';
import 'package:laxia/views/pages/main/contribution/counsel_add_step1.dart';
import 'package:laxia/views/pages/main/contribution/counsel_add_step2.dart';
import 'package:laxia/views/pages/main/contribution/question.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/Login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/passwordResetone':
        return MaterialPageRoute(builder: (_) => PassRest_One());
      case '/PassRest_Three':
        return MaterialPageRoute(builder: (_) => PassRest_Three());
      case '/PassRest_Four':
        return MaterialPageRoute(builder: (_) => PassRest_Four());
      case '/Registration':
        return MaterialPageRoute(builder: (_) => Registration());
      case '/EmailLogin':
        return MaterialPageRoute(builder: (_) => EMLoginScreen());
      case '/Splash':
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());
      case '/Signup':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case '/Pages':
        return MaterialPageRoute(builder: (_) => DashboardScreen());
      case '/Home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      // case '/SearchView':
      //   return MaterialPageRoute(builder: (_) => SearchView());
      case '/SelectPrefecture':
        return MaterialPageRoute(builder: (_) => SelectPrefecture());
      case '/SelectSurgery':
        return MaterialPageRoute(builder: (_) => SelectSurgery());
      case '/NarrowCase':
        return MaterialPageRoute(builder: (_) => NarrowCase());
      case '/NarrowDiary':
        return MaterialPageRoute(builder: (_) => NarrowDiary());
      case '/Appointment':
        return MaterialPageRoute(builder: (_) => Appointment());
      case '/Chat':
        return MaterialPageRoute(
            builder: (_) => ChatScreen(user: favorites[0]));
      case '/Reservation':
        return MaterialPageRoute(builder: (_) => Reservation());
      case '/Confirmation':
        return MaterialPageRoute(builder: (_) => Confirmation());
      case '/Completion':
        return MaterialPageRoute(builder: (_) => Completion());
      case '/Favorite':
        return MaterialPageRoute(builder: (_) => Favorite());
      case '/Mypage':
        return MaterialPageRoute(builder: (_) => Mypage());
      case '/AddDiaryList':
        return MaterialPageRoute(builder: (_) => DiaryPage());
      case '/AddDiaryStep1':
        return MaterialPageRoute(builder: (_) => AddDiaryStep1Page());
      case '/AddDiaryStep2':
        return MaterialPageRoute(builder: (_) => AddDiaryStep2Page());
      case '/AddDiaryStep3':
        return MaterialPageRoute(builder: (_) => AddDiaryStep3Page());
      case '/AddDiaryStep4':
        return MaterialPageRoute(builder: (_) => AddDiaryStep4Page());
      case '/AddDiaryStep5':
        return MaterialPageRoute(builder: (_) => AddDiaryStep5Page());
      case '/AddDiaryProgress':
        return MaterialPageRoute(builder: (_) => AddDiaryProgressPage());
      case '/AddCounselList':
        return MaterialPageRoute(builder: (_) => AddCounselPage());
      case '/AddCounselStep1':
        return MaterialPageRoute(builder: (_) => AddCounselStep1Page());
      case '/AddCounselStep2':
        return MaterialPageRoute(builder: (_) => AddCounselStep2Page());
      case '/AddQuestion':
        return MaterialPageRoute(builder: (_) => AddQuestion());
      default:
        return MaterialPageRoute(builder: (_) => EMLoginScreen());
    }
  }
}
