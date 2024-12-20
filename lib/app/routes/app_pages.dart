import 'package:get/get.dart';

import '../modules/audio-book/bindings/audio_book_binding.dart';
import '../modules/audio-book/views/audio_book_view.dart';
import '../modules/courses/bindings/courses_binding.dart';
import '../modules/courses/views/courses_view.dart';
import '../modules/enroll-course-detail/bindings/enroll_course_detail_binding.dart';
import '../modules/enroll-course-detail/views/enroll_course_detail_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/insight-premium-audio/bindings/insight_premium_audio_binding.dart';
import '../modules/insight-premium-audio/views/insight_premium_audio_view.dart';
import '../modules/lesson-playing/bindings/lesson_playing_binding.dart';
import '../modules/lesson-playing/views/lesson_playing_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ONBOARDING;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.COURSES,
      page: () => const CoursesView(),
      binding: CoursesBinding(),
    ),
    GetPage(
      name: _Paths.ENROLL_COURSE_DETAIL,
      page: () => const EnrollCourseDetailView(),
      binding: EnrollCourseDetailBinding(),
    ),
    GetPage(
      name: _Paths.LESSON_PLAYING,
      page: () => const LessonPlayingView(),
      binding: LessonPlayingBinding(),
    ),
    GetPage(
      name: _Paths.AUDIO_BOOK,
      page: () => const AudioBookView(),
      binding: AudioBookBinding(),
    ),
    GetPage(
      name: _Paths.INSIGHT_PREMIUM_AUDIO,
      page: () => const InsightPremiumAudioView(),
      binding: InsightPremiumAudioBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
  ];
}
