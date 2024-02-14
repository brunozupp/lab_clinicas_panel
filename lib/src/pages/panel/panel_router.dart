import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_panel/src/pages/panel/panel_controller.dart';
import 'package:lab_clinicas_panel/src/pages/panel/panel_page.dart';

class PanelRouter extends FlutterGetItPageRouter {
  
  const PanelRouter({super.key});
  
  @override
  List<Bind<Object>> get bindings => [
    Bind.lazySingleton((i) => PanelController()),
  ];

  @override
  String get routeName => "/panel";

  @override
  WidgetBuilder get view => (_) => const PanelPage();
  
}