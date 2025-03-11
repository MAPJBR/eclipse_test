import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';


import 'package:teste_to_eclipse/app_module.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
await setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ModularApp(module: AppModule(), child: AppWidget());
  }
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Eclipse Test',
      routerConfig: Modular.routerConfig,
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        
      ),
      
    );
  }
  
}

