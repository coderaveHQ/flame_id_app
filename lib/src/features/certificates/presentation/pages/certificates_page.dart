import 'package:flutter/material.dart';

import 'package:flame_id_app/core/extensions/build_context_x.dart';
import 'package:flame_id_app/core/common/widgets/fl_app_bar.dart';
import 'package:flame_id_app/core/common/widgets/fl_scaffold.dart';

class CertificatesPage extends StatelessWidget {

  const CertificatesPage({ super.key });

  @override
  Widget build(BuildContext context) {
    return FLScaffold(
      appBar: FLAppBar(
        context: context,
        title: 'Zertifikate',
        withNavigationRail: context.screenWidth > 480.0
      )
    );
  }
}