// import 'features/product/domain/entities/product.dart';
// import 'package:flutter/material.dart';
// import 'features/product/presentation/screens/home_page.dart';
// import 'features/product/presentation/screens/details_page.dart';
// import 'features/product/presentation/screens/add_update_page.dart';
// import 'features/product/presentation/screens/search_page.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Ecommerce App',
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/',
//       onGenerateRoute: (settings) {
//         switch (settings.name) {
//           case '/':
//             return MaterialPageRoute(builder: (context) => const HomePage());
//           case '/add-update':
//             final product = settings.arguments as Product?;
//             return MaterialPageRoute(
//               builder: (_) => AddUpdatePage(product: product),
//             );
//           case '/details':
//             final product = settings.arguments as Product;
//             return MaterialPageRoute(
//               builder: (_) => DetailsPage(product: product),
//             );
//           case '/search':
//             return MaterialPageRoute(builder: (_) => const SearchPage());
//           default:
//             return null;
//         }
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/signup_page.dart';
import 'features/auth/presentation/pages/splash_page.dart';
import 'features/product/domain/entities/product.dart';
import 'features/product/presentation/screens/home_page.dart';
import 'features/product/presentation/screens/details_page.dart';
import 'features/product/presentation/screens/add_update_page.dart';
import 'features/product/presentation/screens/search_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final AuthRemoteDataSource remoteDataSource = AuthRemoteDataSourceImpl(
    http.Client(),
  );
  final AuthRepository authRepository = AuthRepositoryImpl(remoteDataSource);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc(authRepository)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecommerce App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const SplashPage());
          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginPage());
          case '/signup':
            return MaterialPageRoute(builder: (_) => const SignupPage());
          case '/home':
            return MaterialPageRoute(builder: (_) => const HomePage());
          case '/add-update':
            final product = settings.arguments as Product?;
            return MaterialPageRoute(
              builder: (_) => AddUpdatePage(product: product),
            );
          case '/details':
            final product = settings.arguments as Product;
            return MaterialPageRoute(
              builder: (_) => DetailsPage(product: product),
            );
          case '/search':
            return MaterialPageRoute(builder: (_) => const SearchPage());
          default:
            return MaterialPageRoute(
              builder: (_) =>
                  const Scaffold(body: Center(child: Text('Page not found'))),
            );
        }
      },
    );
  }
}
