import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoping/layout/cubit/layout_cubit.dart';
import 'package:shoping/layout/layout_screen.dart';

import 'package:shoping/shared/constants/constant.dart';
import 'package:shoping/shared/network/local_network.dart';

import 'modules/Screens/authinticationScreen/cubit/auth_cubit.dart';
import 'modules/Screens/authinticationScreen/login_screen.dart';
import 'modules/Screens/darktheme/dark_theme_provider.dart';
import 'modules/Screens/darktheme/theme_style.dart';
import 'shared/bloc_observer/bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //  await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // await EasyLocalization.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheNetwork.cacheInitialization();
  userToken = await CacheNetwork.getCacheData(key: 'token');
  currentPassword = await CacheNetwork.getCacheData(key: 'password');
  debugPrint("User token is : $userToken");
  debugPrint("Current Password is : $currentPassword");
  runApp(MyApp());
  // EasyLocalization(
  //   child: const MyApp(),
  //   supportedLocales: [const Locale('en', 'US'), const Locale('ar', 'AE')],
  //   fallbackLocale: const Locale('en', 'US'),
  //   path: 'assets/translations'));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeController = DarkThemeProvider();

  //* get current theme (dark or light)
  void getCurrentAppTheme() async {
    themeChangeController.setDarkTheme =
        await themeChangeController.darkThemeSetting.getTheme();
  }

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(
            create: (context) => LayoutCubit()
              ..getCarts()
              ..getFavorites()
              ..getBannersData()
              ..getCategoriesData()
              ..getProducts()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: ((context, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => themeChangeController),
            ],
            //* current theme
            child: Consumer<DarkThemeProvider>(
              builder: (context, newValue, child) {
                return MaterialApp(
                  theme: ThemeStyle.themeData(newValue.darkTheme, context),
                  debugShowCheckedModeBanner: false,
                  home:
                      userToken != null ? const LayoutScreen() : LoginScreen(),
                  routes: {
                    LoginScreen.id: (context) => LoginScreen(),
                  },
                );
              },
            ),
          );
        }),
      ),

      //  MaterialApp(
      //     // localizationsDelegates: context.localizationDelegates,
      //     // supportedLocales: context.supportedLocales,
      //     // locale: context.locale,
      //     debugShowCheckedModeBanner: false,
      //     home: userToken != null ? const LayoutScreen() : LoginScreen()),
    );
  }
}
