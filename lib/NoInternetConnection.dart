import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reda/cubit/internet_cubit.dart';

class NoInternetConnectionPage extends StatefulWidget {
  @override
  _NoInternetConnectionPageState createState() =>
      _NoInternetConnectionPageState();
}

class _NoInternetConnectionPageState extends State<NoInternetConnectionPage> {
  late InternetCubit _internetCubit;

  @override
  void initState() {
    super.initState();
    _internetCubit = BlocProvider.of<InternetCubit>(context);

    // Écouter les changements de connexion
    _internetCubit.stream.listen((internetState) {
      // Si la connexion est rétablie
      if (internetState == ConnectivityStatus.connected) {
        // Rediriger l'utilisateur vers la page précédente
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    // Arrêter l'écoute des changements de connexion lorsque la page est détruite
    _internetCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InternetCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('No Internet Connection'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 100,
                color: Colors.red,
              ),
              SizedBox(height: 20),
              Text(
                'No internet connection available.',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
