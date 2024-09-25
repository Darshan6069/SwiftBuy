import 'package:ecommerce_app/Provider/api_provider.dart';
import 'package:ecommerce_app/Provider/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Presentation/SplashScreen/Auth/Ragistration/ragistration_screen.dart';
import 'Presentation/SplashScreen/Tabs/tabs.dart';
import 'Provider/ProductCartProvider/cart_provider.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ApiProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Consumer<AuthProvider>(
          builder: (context, value, child) {
            return value.isLogin()
                ? const TabsScreen()
                : const RagistrationScreen();
          },
        ),
      ),
    );
  }
}
