import 'package:flutter/material.dart';
import 'package:desktop_screenstate/desktop_screenstate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _screenState = DesktopScreenState.instance;
  List stateHistory = [];

  @override
  void initState() {
    super.initState();

    _logScreenState(_screenState.isActive.value);

    _screenState.isActive.addListener(() {
      final state = _screenState.isActive.value;
      _logScreenState(state);
    });
  }

  void _logScreenState(ScreenState state) {
    final timestamp = DateTime.now();
    String displayState = "At $timestamp : Screen is $state";

    stateHistory.add(displayState);
    print(displayState);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ValueListenableBuilder<ScreenState>(
          valueListenable: _screenState.isActive,
          builder: (context, value, child) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListView.builder(
                itemCount: stateHistory.length,
                itemBuilder: (context, index) {
                  return Text(stateHistory[index]);
                },
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
