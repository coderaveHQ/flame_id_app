import 'package:flame_id_app/core/error/failures/failure.dart';

class RealtimeFailure extends Failure {

  const RealtimeFailure()
      : super(
          title: 'Realtime-Fehler',
          description: 'Ein Fehler beim Abonnieren von Realtime-Updates ist aufgetreten.'
        );
}