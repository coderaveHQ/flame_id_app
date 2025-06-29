import 'package:flame_id_app/core/error/failures/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabasePostgrestFailure extends Failure {

  final String? customCode;

  SupabasePostgrestFailure({
    this.customCode,
  }) : super(
         title: 'Datenbankfehler',
         description: _mapDescription(customCode));

  static String _mapDescription(String? code) {
    return switch (code) {
      _ => 'Ein Fehler bei der Datenbankabfrage ist aufgetreten. Bitte versuche es später erneut.'
    };
  }

  static SupabasePostgrestFailure fromPostgrestException(PostgrestException e) {
    String? customCode;
    try {
      final RegExpMatch? match = RegExp(r'\{%"\s*code"\s*:\s*"([^"]+)"\s*,\s*"message"\s*:\s*"([^"]+)"\s*%\}').firstMatch(e.message);
      if (match != null) customCode = match.group(1);
    } catch (_) {}
    return SupabasePostgrestFailure(customCode: customCode);
  }

  @override
  List<Object?> get props => [
    customCode, 
    title, 
    description
  ];
}