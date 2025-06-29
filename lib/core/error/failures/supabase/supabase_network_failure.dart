import 'package:flame_id_app/core/error/failures/failure.dart';

class SupabaseNetworkFailure extends Failure {
  
  const SupabaseNetworkFailure.noConnection()
      : super(
          title: 'Keine Internetverbindung',
          description: 'Bitte überprüfen Sie Ihre Internetverbindung und versuchen Sie es erneut.'
        );

  const SupabaseNetworkFailure.timeout()
      : super(
          title: 'Anfragezeitüberschreitung',
          description: 'Die Verbindung zum Server hat zu lange gedauert. Bitte versuchen Sie es später erneut.'
        );
}