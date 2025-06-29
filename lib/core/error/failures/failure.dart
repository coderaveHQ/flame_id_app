import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

import 'package:flame_id_app/core/utils/toaster.dart';

abstract class Failure extends Equatable {

  final String title;
  final String description;
  final StackTrace? stackTrace;

  const Failure({
    required this.title,
    required this.description,
    this.stackTrace
  });

  const Failure.unknown({
    this.stackTrace,
  }) : title = 'Unbekannter Fehler',
       description = 'Ein unbekannter Fehler ist aufgetreten.';

  void showToast(BuildContext context) {
    Toaster.showError(
      context: context,
      title: title,
      description: description
    );
  }

  @override
  List<Object?> get props => [
    title, 
    description, 
    stackTrace
  ];
}