import 'package:flipit/src/state/bloc/sound/sound_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Inherit this State to be notified of lifecycle events, including popping and pushing routes.
///
/// Use `pushNamed()` or `push()` method to track lifecycle events when navigating to another route.
abstract class LifecycleState<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver {
  ResumeResult resumeResult = ResumeResult();
  bool _isPaused = false;

  AppLifecycleState lastAppState = AppLifecycleState.resumed;

  void onResume() {
    _isPaused = false;
    BlocProvider.of<SoundBloc>(context).add(ResumeSound());
  }

  void onPause() {
    _isPaused = true;
    BlocProvider.of<SoundBloc>(context).add(PauseSound());
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      if (!_isPaused) {
        onPause();
      }
    } else if (state == AppLifecycleState.resumed &&
        lastAppState == AppLifecycleState.paused) {
      if (_isPaused) {
        onResume();
      }
    }
    lastAppState = state;
  }
}

class ResumeResult {
  dynamic data;
  late String source;
}
