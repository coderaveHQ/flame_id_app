import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flame_id_app/core/res/theme/colors/fl_colors.dart';
import 'package:flame_id_app/core/utils/env.dart';
import 'package:flame_id_app/src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _loadEnv();

  await _initializeSupabase();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: FLColors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: FLColors.white,
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark
    )
  );

  runApp(
    const ProviderScope(
      child: App()
    )
  );
}

Future<void> _loadEnv() async {
  await dotenv.load(fileName: 'dotenv');
}

Future<void> _initializeSupabase() async {
  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseAnonKey,
    authOptions: const FlutterAuthClientOptions(detectSessionInUri: false)
  );
}