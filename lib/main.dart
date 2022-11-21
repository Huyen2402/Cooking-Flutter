import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'ui/screens.dart';

Future<void>  main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (cyx) => AuthManager(),
        ),
        ChangeNotifierProxyProvider<AuthManager, MenuManager>(
          create: (ctx) => MenuManager(),
          update: (ctx, authManager, productsManager) {
          // Khi authManager có báo hiệu thay đổi thì đọc lại authToken
          // cho productManager
          productsManager!.authToken = authManager.authToken;
          return productsManager;
          },
          ),
        ChangeNotifierProvider(
          create: (cyx) => ListMenuManager(),
        ),
      ],
      child: Consumer<AuthManager>(
        builder: (context, authManager, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Cooking with me',
            theme: ThemeData(
              backgroundColor: Colors.deepPurple,
              appBarTheme: const AppBarTheme(color: Colors.deepPurple, elevation: 0),
              visualDensity: VisualDensity.adaptivePlatformDensity
            ),
            // title: 'My Shop',
            // debugShowCheckedModeBanner: false,
            // theme: ThemeData(
            //   fontFamily: 'Lato',
            
            //   colorScheme: ColorScheme.fromSwatch(
            //     primarySwatch: Colors.blueGrey,
            //   ).copyWith(
            //     secondary: Colors.pink,
            //   ),
            // ),
            home: authManager.isAuth ? const ProductOverviewScreen() : FutureBuilder(
              future: authManager.tryAutoLogin(),
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.waiting ? const SplashScreen() : const AuthScreen();
              }),
            routes: {
              ListMenuScreen.routeName: (context) => const ListMenuScreen(),
              // OrdersScreen.routeName: (context) => const OrdersScreen(),
              UserProductScreen.routeName: (context) => const UserProductScreen(),
              
            },
            onGenerateRoute: (settings) {
              if (settings.name == EditMenuScreen.routeName) {
                final productId = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return EditMenuScreen(
                     
                           ctx.read<MenuManager>().findById(productId),
                          
                    );
                  },
                );
              }
              if (settings.name == ProductDetailScreen.routeName) {
                final productId = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return ProductDetailScreen(
                     
                           ctx.read<MenuManager>().findById(productId),
                          
                    );
                  },
                );
              }
              return null;
            },
            
            



            
          );
        }
      ),
    );
  }
}
