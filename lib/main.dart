//package
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
//screen
import './screens/TabScreen.dart';
import './screens/loginScreen.dart';

//providers
import './providers/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: User())],
      child: MaterialApp(
        title: 'Courscate & Zujo',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
          primaryColor: Colors.black,
          backgroundColor: Colors.black,
          canvasColor: Colors.black,
          accentColor: Colors.yellow,
          brightness: Brightness.dark,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Consumer<User>(
          builder: (ctx, user, _) => StreamBuilder(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (ctx, userSnapShot) {
              if (userSnapShot.hasData) {
                return FutureBuilder(
                    future: user.autoLogin(),
                    builder: (ctx, snapshhot) {
                      if (snapshhot.connectionState ==
                          ConnectionState.waiting) {
                        return Scaffold(
                          body: Center(
                              child: CircularProgressIndicator(
                            strokeWidth: 1,
                          )),
                        );
                      }
                      return TabScreen();
                    });
              }
              return AuthScreen();
            },
          ),
        ),
      ),
    );
  }
}
