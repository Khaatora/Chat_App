import 'package:chat_own/firebase_options.dart';
import 'package:chat_own/models/chat_room.dart';
import 'package:chat_own/modules/add_room/add_room_view.dart';
import 'package:chat_own/modules/chat_screen/chat_room_view.dart';
import 'package:chat_own/modules/create_account/create_account_view.dart';
import 'package:chat_own/modules/home_screen/home_view.dart';
import 'package:chat_own/modules/login_screen/login_view.dart';
import 'package:chat_own/providers/my_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
    create: (context) => MyProvider(),
    lazy: false,
    builder: (context, child) {
      return const MyApp();
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    User? currentUser = context.select<MyProvider, User?>((provider) => provider.firebaseUser);
    String initialRoute = currentUser != null
        ? HomeView.routeName
        : LoginView.routeName;
    return MaterialApp(
      initialRoute: initialRoute,
      onGenerateRoute: (settings) {
        var routes = <String, WidgetBuilder>{
          CreateAccountView.routeName: (context) => CreateAccountView(),
          LoginView.routeName: (context) => const LoginView(),
          HomeView.routeName: (context) => const HomeView(),
          AddRoomView.routeName: (context) => const AddRoomView(),
          ChatRoomView.routeName: (context) => ChatRoomView(settings.arguments as ChatRoomModel),
        };
        WidgetBuilder? builder = routes[settings.name];
        return MaterialPageRoute(builder: (context) => builder!(context),);
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
