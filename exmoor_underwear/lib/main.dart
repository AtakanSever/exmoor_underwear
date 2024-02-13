import 'package:exmoor_underwear/application/depo/depo_bloc.dart';
import 'package:exmoor_underwear/application/hesaplar/hesaplar_bloc.dart';
import 'package:exmoor_underwear/firebase_options.dart';
import 'package:exmoor_underwear/navbar.dart';
import 'package:exmoor_underwear/presentation/pages/depo/add_product.dart';
import 'package:exmoor_underwear/presentation/pages/login/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<DepoBloc>(
            create: (context) => DepoBloc()),
            BlocProvider<HesaplarBloc>(
            create: (context) => HesaplarBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
        ),
        home: Navbar(),
      ),
    );
  }
}
