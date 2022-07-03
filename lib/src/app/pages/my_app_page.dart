import 'package:crossingwords/src/main_menu/pages/main_menu_page.dart';
import 'package:crossingwords/src/options/pages/option_page.dart';
import 'package:crossingwords/src/state/bloc/help_menu/helpmenu_bloc.dart';
import 'package:crossingwords/src/theme/main_theme.dart';
import 'package:crossingwords/src/ui/my_transition.dart';
import 'package:flutter/material.dart';
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
        builder: (context, state) => MainMenuPage(key: const Key('main menu')),
      ),
      GoRoute(
        path: '/board/play',
        name: 'play',
        pageBuilder: (context, state) => buildMyTransition(
          child: const PlayPage(key: Key('board/play')),
          color: darkColor,
        ),
      ),
      GoRoute(
        path: '/options',
        name: 'options',
        pageBuilder: (context, state) => buildMyTransition(
          child: const OptionsPage(key: Key('options')),
          color: darkColor,
        ),
      ),
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
        //initialRoute: '/',
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        // routes: [
        //   '/': (context) => MainMenuPage(),
        //   '/board/play': (context) => const PlayPage(),
        //   '/options': (context) => const OptionsPage(),
        // ],
        theme: mainTheme,
      ),
    );
  }
}
