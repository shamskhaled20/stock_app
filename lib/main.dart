import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:stocktaking_app/view/home.dart';
import 'package:stocktaking_app/view/stock_view.dart';

import 'data/cubit/cubit.dart';

void main() {
  // Initialize sqflite_common_ffi
  sqfliteFfiInit();

  // Set the factory to use FFI
  databaseFactory = databaseFactoryFfi;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ItemsCubit>(
          create: (context) => ItemsCubit(),
        ),
        BlocProvider<StockRecordsCubit>(
          create: (context) => StockRecordsCubit(),
        ),
      ],
      child: MaterialApp(
        home: Home(),
      ),
    );
  }
}
