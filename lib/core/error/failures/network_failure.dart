import 'package:flame_id_app/core/error/failures/failure.dart';

class NetworkFailure extends Failure {

  const NetworkFailure.noConnection()
      : super(
          title: 'Keine Internetverbindung',
          description: 'Bitte überprüfen Sie Ihre Internetverbindung und versuchen Sie es erneut.'
        );

  const NetworkFailure.timeout()
      : super(
          title: 'Anfragezeitüberschreitung',
          description: 'Die Verbindung zum Server hat zu lange gedauert. Bitte versuchen Sie es später erneut.'
        );
}