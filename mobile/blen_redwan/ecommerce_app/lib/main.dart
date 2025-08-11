import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

// Auth imports
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_state.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/signup_page.dart';
import 'features/auth/presentation/pages/splash_page.dart';

// Product imports
import 'features/product/domain/entities/product.dart';
import 'features/product/presentation/screens/home_page.dart';
import 'features/product/presentation/screens/details_page.dart';
import 'features/product/presentation/screens/add_update_page.dart';
import 'features/product/presentation/screens/search_page.dart';

// Chat imports
import 'features/chat/data/datasources/chat_remote_data_source.dart';
import 'features/chat/data/repositories/chat_repository_impl.dart';
import 'features/chat/presentation/bloc/chat_bloc.dart';
import 'features/chat/presentation/bloc/chat_event.dart';
import 'features/chat/presentation/pages/chat_list_page.dart';
import 'features/chat/presentation/pages/chat_page.dart';
import 'features/chat/data/datasources/chat_socket_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Auth setup
  final authRemoteDataSource = AuthRemoteDataSourceImpl(http.Client());
  final authRepository = AuthRepositoryImpl(authRemoteDataSource);

  // Chat setup
  final chatSocketService = ChatSocketService();
  final chatRemoteDataSource = ChatRemoteDataSourceImpl(
    chatSocketService,
    http.Client(),
  );
  final chatRepository = ChatRepositoryImpl(chatRemoteDataSource);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc(authRepository)),
        BlocProvider<ChatBloc>(create: (_) => ChatBloc(chatRepository)),
      ],
      child: MyApp(chatSocketService: chatSocketService),
    ),
  );
}

class MyApp extends StatelessWidget {
  final ChatSocketService chatSocketService;
  const MyApp({super.key, required this.chatSocketService});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is Authenticated || current is Unauthenticated,
      listener: (context, state) {
        if (state is Authenticated) {
          // Get token from user inside Authenticated state
          final token = state.user.token;
          chatSocketService.setToken(token);
          context.read<ChatBloc>().add(ChatConnectRequested());
        } else if (state is Unauthenticated) {
          chatSocketService.disconnect();
        }
      },
      child: MaterialApp(
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
            case '/chats':
              return MaterialPageRoute(builder: (_) => ChatListPage());
            case '/chat':
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (_) => ChatPage(
                  chat: args['chat'],
                  avatarImage: args['avatarImage'],
                  bgColor: args['bgColor'],
                ),
              );
            default:
              return MaterialPageRoute(
                builder: (_) =>
                    const Scaffold(body: Center(child: Text('Page not found'))),
              );
          }
        },
      ),
    );
  }
}
