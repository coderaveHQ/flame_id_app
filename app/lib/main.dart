import 'package:flutter/material.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flame_id_app/firebase_options.dart';
import 'package:flame_id_app/src/app.dart';
import 'package:flame_id_app/core/utils/env.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await loadEnv();

  await initializeSupabase();
  await initializeFirebase();

  runApp(const App());
}

Future<void> loadEnv() async {
  await dotenv.load();
}

Future<void> initializeSupabase() async {
  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseAnonKey,
    authOptions: const FlutterAuthClientOptions(detectSessionInUri: false)
  );
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}