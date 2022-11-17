import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/initialize/initialize_bloc.dart';

class OpeningScreen extends StatefulWidget {
  const OpeningScreen({Key? key}) : super(key: key);

  @override
  State<OpeningScreen> createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen> {
  final InitializeBloc _initializeBloc = InitializeBloc();

  @override
  void initState() {
    super.initState();
    _initializeBloc.add(InitializeAppEvent());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              child: Image.asset('assets/images/icon.png'),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'iBlock',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 40,
            ),
            const CircularProgressIndicator(
              color: Colors.greenAccent,
            ),
            const SizedBox(
              height: 20,
            ),
            BlocProvider(
              create: (context) => _initializeBloc,
              child: BlocConsumer<InitializeBloc, InitializeState>(
                listenWhen: ((previous, current) => previous != current),
                listener: (BuildContext context, state) {
                  if (state is NoInternetConnection) {
                    Navigator.popAndPushNamed(context, '/error', arguments: {
                      "message": "No internet connection found!"
                    });
                  } else if (state is Registered) {
                    Navigator.popAndPushNamed(context, '/home',
                        arguments: state.userInfo);
                  } else if (state is PartiallyRegistered) {
                    Navigator.popAndPushNamed(context, '/enter-address');
                  } else if (state is NotRegistered) {
                    Navigator.popAndPushNamed(context, '/welcome1');
                  } else if (state is Failed) {
                    Navigator.popAndPushNamed(context, '/error',
                        arguments: {"message": state.message});
                  }
                },
                buildWhen: ((previous, current) =>
                    previous != current &&
                    (current is Initial ||
                        current is CheckingInternetConnection ||
                        current is Authenticating ||
                        current is Authenticated)),
                builder: (context, state) {
                  if (state is Initial) {
                    return const Text("Initializing");
                  } else if (state is CheckingInternetConnection) {
                    return const Text("Checking for connectivity");
                  } else if (state is Authenticating) {
                    return const Text("Authenticating");
                  } else if (state is Authenticated) {
                    return const Text("Authenticated");
                  }
                  return const Text("Something went wrong!");
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _navigateToWelcomeScreen1(BuildContext context) {
    Navigator.popAndPushNamed(context, '/welcome1');
  }
}
