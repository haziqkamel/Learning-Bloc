import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:learning_bloc/logic/cubit/internet_cubit.dart';
import 'package:learning_bloc/logic/cubit/settings_cubit.dart';
import 'package:learning_bloc/logic/utility/app_bloc_observer.dart';

import 'package:learning_bloc/presentation/router/app_router.dart';
import 'package:learning_bloc/presentation/screens/home_screen.dart';
import 'package:path_provider/path_provider.dart';

import '/logic/cubit/counter_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Native code required WidgetsFlutterBinding
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  Bloc.observer = AppBlocObserver();

  runApp(MyApp(
    appRouter: AppRouter(),
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;

  const MyApp({
    Key key,
    @required this.appRouter,
    @required this.connectivity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(),
        ),
        BlocProvider<SettingsCubit>(
          create: (context) => SettingsCubit(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(
          title: 'Flutter Demo Home Page',
          color: Colors.blueAccent,
        ),
        // home: SettingsScreen(),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
