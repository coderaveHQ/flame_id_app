import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'package:flame_id_app/core/utils/env.dart';
import 'package:flame_id_app/src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initializeSupabase();

  usePathUrlStrategy();

  GoRouter.optionURLReflectsImperativeAPIs = true;

  runApp(
    ProviderScope(
      child: const App()
    )
  );
}

Future<void> _initializeSupabase() async {
  await Supabase.initialize(
    url: Env.supabaseUrl, 
    anonKey: Env.supabaseAnonKey
  );
}