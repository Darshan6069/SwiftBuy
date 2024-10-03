import 'package:ecommerce_app/Provider/api_provider.dart';
import 'package:ecommerce_app/Provider/order_provider.dart';
import 'package:ecommerce_app/Provider/razorpay_provider.dart';
import 'package:ecommerce_app/Provider/signup_provider.dart';
import 'package:ecommerce_app/core/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Presentation/Auth/Ragistration/ragistration_screen.dart';
import 'Presentation/Tabs/tabs.dart';
import 'Provider/cart_provider.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localization/flutter_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final localization = FlutterLocalization.instance;

  void _initialiseLocale() {
    localization.init(
      mapLocales: [
        const MapLocale('en', AppLocale.en),
        const MapLocale('es', AppLocale.es),
      ],
      initLanguageCode: 'en',
    );
    localization.onTranslatedLanguage = _onTranslatedLanguage;
  }

  _onTranslatedLanguage(Locale? locale) {
    setState(() {
      localization.translate('es');
    });
  }

  @override
  void initState() {
    super.initState();
    _initialiseLocale();
  }

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
        ChangeNotifierProvider(
          create: (context) => RazorpayProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        )
      ],
      child: MaterialApp(
        supportedLocales: localization.supportedLocales,
        localizationsDelegates: localization.localizationsDelegates,
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
                : RagistrationScreen(
                    onLocaleChange: () {
                      _onTranslatedLanguage(const Locale('en'));
                    },
                  );
          },
        ),
      ),
    );
  }
}
