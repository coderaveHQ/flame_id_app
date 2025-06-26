import 'package:flame_id_app/core/error/failures/failure.dart';

class FunctionFailure extends Failure {

  const FunctionFailure()
      : super(
          title: 'Funktionsfehler',
          description: 'Ein Fehler bei der Ausführung einer Supabase-Funktion ist aufgetreten.'
        );
}