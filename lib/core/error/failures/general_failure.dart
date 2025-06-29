import 'package:flame_id_app/core/error/failures/failure.dart';

class GeneralFailure extends Failure {
  
  const GeneralFailure.unexpected({
    super.stackTrace
  }) : super(
         title: 'Unerwarteter Fehler',
         description: 'Ein unerwarteter Fehler ist aufgetreten. Bitte versuchen Sie es später erneut.');
}