import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_panel/src/pages/panel/panel_controller.dart';
import 'package:lab_clinicas_panel/src/pages/panel/panel_page.dart';
import 'package:lab_clinicas_panel/src/repositories/panel_checkin/i_panel_checkin_repository.dart';
import 'package:lab_clinicas_panel/src/repositories/panel_checkin/panel_checkin_repository.dart';

class PanelRouter extends FlutterGetItPageRouter {
  
  const PanelRouter({super.key});
  
  @override
  List<Bind<Object>> get bindings => [
    Bind.lazySingleton<IPanelCheckinRepository>((i) => PanelCheckinRepository(restClient: i())),
    Bind.lazySingleton((i) => PanelController(
      panelCheckinRepository: i(),
    )),
  ];

  @override
  String get routeName => "/panel";

  @override
  WidgetBuilder get view => (_) => const PanelPage();
  
}