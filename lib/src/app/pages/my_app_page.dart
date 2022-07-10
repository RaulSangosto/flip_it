import 'package:crossingwords/src/main_menu/pages/main_menu_page.dart';
import 'package:crossingwords/src/options/pages/credits.dart';
import 'package:crossingwords/src/options/pages/option_page.dart';
import 'package:crossingwords/src/state/bloc/help_menu/helpmenu_bloc.dart';
import 'package:crossingwords/src/theme/main_theme.dart';
import 'package:crossingwords/src/ui/my_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../game/pages/play_page.dart';
import '../../state/bloc/game/game_bloc.dart';
import '../../state/bloc/sound/sound_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'main menu',
        builder: (context, state) => AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
          ),
          child: MainMenuPage(key: const Key('main menu')),
        ),
      ),
      GoRoute(
        path: '/board/play',
        name: 'play',
        pageBuilder: (context, state) => buildMyTransition(
          child: const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark,
            ),
            child: PlayPage(key: Key('board/play')),
          ),
          color: darkColor,
        ),
      ),
      GoRoute(
          path: '/options',
          name: 'options',
          pageBuilder: (context, state) => buildMyTransition(
                child: const AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle(
                    statusBarBrightness: Brightness.dark,
                    statusBarIconBrightness: Brightness.light,
                  ),
                  child: OptionsPage(key: Key('options')),
                ),
                color: darkColor,
              ),
          routes: [
            GoRoute(
              path: 'options/credits',
              name: 'credits',
              pageBuilder: (context, state) => buildMyTransition(
                child: const AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle(
                    statusBarBrightness: Brightness.dark,
                    statusBarIconBrightness: Brightness.light,
                  ),
                  child: CreditsPage(key: Key('credits')),
                ),
                color: white,
              ),
            ),
          ]),
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("assets/images/Logo_text.png"), context);
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
        theme: mainTheme,
      ),
    );
  }
}
