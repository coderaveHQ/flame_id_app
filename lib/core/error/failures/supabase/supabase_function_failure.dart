import 'package:flame_id_app/core/error/failures/failure.dart';

class SupabaseFunctionFailure extends Failure {

  const SupabaseFunctionFailure()
      : super(
          title: 'Funktionsfehler',
          description: 'Ein Fehler bei der Ausführung einer Supabase-Funktion ist aufgetreten.'
        );
}