import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../game/widgets/help_area.dart';
import '../../game/widgets/menus.dart';
import '../../state/bloc/help_menu/helpmenu_bloc.dart';
import '../../state/bloc/sound/sound_bloc.dart';
import '../../state/bloc/sound/sound_model.dart';
import '../../theme/main_theme.dart';
import '../../ui/background.dart';
import '../../ui/widgets.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({Key? key}) : super(key: key);

  _onRestartMenu(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return BluredBackground(
      child: Scaffold(
        onEndDrawerChanged: (isOpened) {
          BlocProvider.of<SoundBloc>(context)
              .add(PlaySound(isOpened ? SoundType.open : SoundType.close));
        },
        backgroundColor: Colors.transparent,
        endDrawer: DrawerMenu(
          onRestart: _onRestartMenu,
        ),
        body: BlocBuilder<HelpMenuBloc, HelpMenuState>(
          builder: (context, helpMenuState) {
            return Stack(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleIconButton(
                              backgroundColor: accentColor,
                              radius: 40,
                              onPressed: () {
                                Scaffold.of(context).openEndDrawer();
                              },
                              icon: Icon(
                                Icons.grid_view_rounded,
                                color: Theme.of(context).iconTheme.color,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                HelpArea(
                  finished: false,
                  win: false,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
