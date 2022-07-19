import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../game/pages/play_page.dart';
import '../../main_menu/pages/main_menu_page.dart';
import '../../options/pages/credits.dart';
import '../../options/pages/deck_settings_page.dart';
import '../../options/pages/option_page.dart';
import '../../state/bloc/game/game_bloc.dart';
import '../../state/bloc/help_menu/helpmenu_bloc.dart';
import '../../state/bloc/sound/sound_bloc.dart';
import '../../state/bloc/sound/sound_model.dart';
import '../../theme/main_theme.dart';
import '../../tutorial/pages/tutorial_page.dart';
import '../../ui/my_transition.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'main menu',
        builder: (context, state) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark,
            ),
            child: MainMenuPage(key: const Key('main menu')),
          );
        },
      ),
      GoRoute(
        path: '/board/play',
        name: 'play',
        pageBuilder: (context, state) {
          return buildMyTransition(
            name: 'play',
            child: const AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.dark,
              ),
              child: PlayPage(key: Key('board/play')),
            ),
            color: darkColor,
          );
        },
      ),
      GoRoute(
        path: '/tutorial',
        name: 'tutorial',
        pageBuilder: (context, state) {
          return buildMyTransition(
            name: 'tutorial',
            child: const AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.dark,
              ),
              child: TutorialPage(key: Key('tutorial')),
            ),
            color: darkColor,
          );
        },
      ),
      GoRoute(
          path: '/options',
          name: 'options',
          pageBuilder: (context, state) {
            return buildMyTransition(
              name: 'options',
              child: const AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.dark,
                  statusBarIconBrightness: Brightness.light,
                ),
                child: OptionsPage(key: Key('options')),
              ),
              color: darkColor,
            );
          },
          routes: [
            GoRoute(
              path: 'options/credits',
              name: 'credits',
              pageBuilder: (context, state) {
                return buildMyTransition(
                  name: 'credits',
                  child: const AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle(
                      statusBarBrightness: Brightness.dark,
                      statusBarIconBrightness: Brightness.light,
                    ),
                    child: CreditsPage(key: Key('credits')),
                  ),
                  color: white,
                );
              },
            ),
            GoRoute(
              path: 'options/deck-settings',
              name: 'deck-settings',
              pageBuilder: (context, state) {
                return buildMyTransition(
                  name: 'deck-settings',
                  child: const AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle(
                      statusBarBrightness: Brightness.dark,
                      statusBarIconBrightness: Brightness.light,
                    ),
                    child: DeckSettingsPage(key: Key('deck-settings')),
                  ),
                  color: darkColor,
                );
              },
            ),
          ]),
    ],
    observers: [MyNavObserver()],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("assets/images/Logo_text.png"), context);
    log(EasyLocalization.of(context)?.locale.toString() ?? "",
        name: "${toString()}# locale");
    log(Intl.defaultLocale.toString(),
        name: "${toString()}# Intl.defaultLocale");
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameBloc>(
          create: (_) => GameBloc(),
        ),
        BlocProvider<HelpMenuBloc>(
          create: (_) => HelpMenuBloc(),
        ),
        BlocProvider<SoundBloc>(
          create: (_) => SoundBloc(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: mainTheme,
      ),
    );
  }
}

class MyNavObserver extends NavigatorObserver {
  MyNavObserver();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _playSongForRoute(route.navigator?.context, route);

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _playSongForRoute(route.navigator?.context, previousRoute);

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _playSongForRoute(route.navigator?.context, route);

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null) {
      _playSongForRoute(newRoute.navigator?.context, newRoute);
    }
  }
}

void _playSongForRoute(BuildContext? context, Route<dynamic>? route) {
  if (context != null) {
    ThemeSongs? song;
    switch (route?.name) {
      case "main menu":
        song = ThemeSongs.mainMenu;
        break;
      case "play":
        song = ThemeSongs.playArea;
        break;
      case "credits":
        song = ThemeSongs.credits;
        break;
    }
    if (song != null) {
      BlocProvider.of<SoundBloc>(context).add(PlaySong(song));
    }
  }
}

extension on Route<dynamic> {
  String? get name => settings.name;
}
