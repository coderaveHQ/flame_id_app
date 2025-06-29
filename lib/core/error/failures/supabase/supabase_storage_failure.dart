import 'package:flame_id_app/core/error/failures/failure.dart';

class SupabaseStorageFailure extends Failure {

  const SupabaseStorageFailure()
      : super(
          title: 'Speicherfehler',
          description: 'Ein Fehler beim Zugriff auf den Speicherdienst ist aufgetreten.'
        );
}