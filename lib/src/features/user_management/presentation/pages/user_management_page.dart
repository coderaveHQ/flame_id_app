import 'package:flutter/material.dart';

import 'package:flame_id_app/core/common/widgets/fl_app_bar.dart';
import 'package:flame_id_app/core/common/widgets/fl_scaffold.dart';

class UserManagementPage extends StatelessWidget {

  const UserManagementPage({ super.key });

  @override
  Widget build(BuildContext context) {
    return FLScaffold(
      appBar: FLAppBar(
        context: context,
        title: 'Benutzerverwaltung'
      )
    );
  }
}