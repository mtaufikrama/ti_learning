part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const COURSES = _Paths.COURSES;
  static String ENROLL_COURSE_DETAIL(String id) => '/courses/$id';
  static const LESSON_PLAYING = _Paths.LESSON_PLAYING;
  static const AUDIO_BOOK = _Paths.AUDIO_BOOK;
  static const INSIGHT_PREMIUM_AUDIO = _Paths.INSIGHT_PREMIUM_AUDIO;
  static const ONBOARDING = _Paths.ONBOARDING;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const COURSES = '/courses';
  static const ENROLL_COURSE_DETAIL = '/courses/:id';
  static const LESSON_PLAYING = '/lesson-playing';
  static const AUDIO_BOOK = '/audio-book';
  static const INSIGHT_PREMIUM_AUDIO = '/insight-premium-audio';
  static const ONBOARDING = '/onboarding';
}
