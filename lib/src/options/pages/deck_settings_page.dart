import 'package:easy_localization/easy_localization.dart';
import 'package:flipit/src/state/bloc/game/game_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../theme/main_theme.dart';

class DeckSettingsPage extends StatelessWidget {
  const DeckSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "deck_settings_title",
                        style: deckTextStyle,
                      ).tr(),
                    ],
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  const DeckSettingsItems(),
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(
                        Icons.error_outline_rounded,
                        color: white,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        child: Text(
                          "deck_settings_warning",
                          style: bodyTextWhiteStyle.copyWith(fontSize: 12),
                        ).tr(),
                      ),
                    ],
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                  ElevatedButton(
                    style: secondaryButton,
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    child: const Text("back_button").tr(),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DeckSettingsItems extends StatelessWidget {
  const DeckSettingsItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return Column(
          children: [
            SettingsItem(
              text: "Max Card Number",
              value: state.controller.maxCardNumber,
              onClick: () =>
                  BlocProvider.of<GameBloc>(context).add(ChangeMaxCardNumber()),
            ),
            SettingsItem(
              text: "Number of Decks",
              value: state.controller.decksNumber,
              onClick: () =>
                  BlocProvider.of<GameBloc>(context).add(ChangeDecksNumber()),
            ),
            SettingsItem(
              text: "Hand Size",
              value: state.controller.handSize,
              onClick: () =>
                  BlocProvider.of<GameBloc>(context).add(ChangeHandSize()),
            ),
            SettingsItem(
              text: "Special Cards Amount",
              value: state.controller.specialCardsAmount.name,
              onClick: () => BlocProvider.of<GameBloc>(context)
                  .add(ChangeSpecialCardsAmount()),
            ),
          ],
        );
      },
    );
  }
}

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    Key? key,
    required this.text,
    required this.onClick,
    required this.value,
  }) : super(key: key);

  final String text;
  final VoidCallback onClick;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              style:
                  Theme.of(context).textTheme.headline6?.copyWith(color: white),
            ),
          ),
          OutlinedButton(
              style: lightOutlineCompressedButtonStyle,
              onPressed: onClick,
              child: Text(value.toString())),
        ],
      ),
    );
  }
}
