import 'package:flame_id_app/core/error/failures/failure.dart';

class StorageFailure extends Failure {

  const StorageFailure()
      : super(
          title: 'Speicherfehler',
          description: 'Ein Fehler beim Zugriff auf den Speicherdienst ist aufgetreten.'
        );
}