import 'package:ecommerce_app/utils/app_router.dart';
import 'package:ecommerce_app/utils/app_routes.dart';
import 'package:ecommerce_app/view_models/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/view_models/favourite_cubit/favourite_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  await initializaApp();
  runApp(const MyApp());
}

Future<void> initializaApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await handleNotifications();
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  debugPrint('Handling a background message: ${message.messageId}');
}

Future<void> handleNotifications() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  NotificationSettings settings = await firebaseMessaging.requestPermission(
      // alert: true,
      // announcement: false,
      // badge: true,
      // carPlay: false,
      // criticalAlert: false,
      // provisional: false,
      // sound: true,
      );
  debugPrint('User Granted Permissions : ${settings.authorizationStatus}');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('Got a message whilst in the foreground!');
    debugPrint('Message data: ${message.data}');

    if (message.notification != null) {
      String title = message.notification!.title ?? '';
      String body = message.notification!.body ?? '';
      debugPrint('Message also contained a notification Title: $title');
      debugPrint('Message also contained a notification Body : $body');

      showDialog(
          context: navigatorKey.currentContext!,
          builder: (_) {
            return AlertDialog(
              title: Text(title),
              content: Text(body),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(navigatorKey.currentContext!).pop();
                    },
                    child: const Text('Ok'))
              ],
            );
          });
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint('A New Message onMessageOpenedApp even was published');
    debugPrint('Message data ${message.data}');
    final messageData = message.data;
    if (messageData['product_id'] != null) {
      navigatorKey.currentState!.pushNamed(AppRoutes.productDetailRoute,
      arguments: messageData['product_id']);
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) {
            final cubit = AuthCubit();
            cubit.checkAuth();
            return cubit;
          },
        ),
        BlocProvider<FavouriteCubit>(
          create: (context) {
            final cubit = FavouriteCubit();
            cubit.getFavouriteProducts();
            return cubit;
          },
        ),
      ],
      child: Builder(
        builder: (context) {
          final authCubit = BlocProvider.of<AuthCubit>(context);
          return BlocBuilder<AuthCubit, AuthState>(
            bloc: authCubit,
            buildWhen: (previous, current) =>
                current is AuthDone || current is AuthInitial,
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'E-Commerce App',
                navigatorKey: navigatorKey,
                theme: ThemeData(fontFamily: 'Roboto'),
                initialRoute: state is AuthDone
                    ? AppRoutes.homeRoute
                    : AppRoutes.loginRoute,
                onGenerateRoute: AppRouter.onGenerateRoute,
              );
            },
          );
        },
      ),
    );
  }
}
