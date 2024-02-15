import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_panel/src/pages/panel/panel_controller.dart';
import 'package:lab_clinicas_panel/src/pages/panel/widgets/panel_main_widget.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../models/panel_checkin_model.dart';
import 'widgets/password_tile_widget.dart';

class PanelPage extends StatefulWidget {
  const PanelPage({super.key});

  @override
  State<PanelPage> createState() => _PanelPageState();
}

class _PanelPageState extends State<PanelPage> with MessageViewMixin {

  final _controller = Injector.get<PanelController>();

  @override
  void initState() {
    messageListener(_controller);

    _controller.listenerPanel();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final sizeOf = MediaQuery.sizeOf(context);

    final PanelCheckinModel? current;
    final PanelCheckinModel? lastCall;
    final List<PanelCheckinModel>? others;

    // watch(context) -> faz com que minha tela fique escutando as alterações nessa variável "paienlData"
    // é como se envolvesse todo o meu build num widget especializado em observar as mudanças em "painelData"
    final listPanel = _controller.painelData.watch(context);

    current = listPanel.firstOrNull;
    
    if(listPanel.isNotEmpty) {
      listPanel.removeAt(0);
    }

    lastCall = listPanel.firstOrNull;

    if(listPanel.isNotEmpty) {
      listPanel.removeAt(0);
    }

    others = listPanel;

    return Scaffold(
      appBar: LabClinicasAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                lastCall != null
                  ? SizedBox(
                    width: sizeOf.width * 0.4,
                    child: PanelMainWidget(
                      passwordLabel: "Senha anterior",
                      password: lastCall.password,
                      deskNumber: lastCall.attendantDesk.toString(),
                      labelColor: LabClinicasTheme.blueColor,
                      buttonColor: LabClinicasTheme.orangeColor,
                    ),
                  )
                  : const SizedBox.shrink(),
                
                const SizedBox(
                  width: 20,
                ),
                current != null 
                  ? SizedBox(
                    width: sizeOf.width * 0.4,
                    child: PanelMainWidget(
                      passwordLabel: "Chamando senha",
                      password: current.password,
                      deskNumber: current.attendantDesk.toString(),
                      labelColor: LabClinicasTheme.orangeColor,
                      buttonColor: LabClinicasTheme.blueColor,
                    ),
                  )
                  : const SizedBox.shrink(),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            const Divider(
              color: LabClinicasTheme.orangeColor,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Últimos chamados",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: LabClinicasTheme.orangeColor,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              runAlignment: WrapAlignment.center,
              children: others.map((panel) => PasswordTileWidget(
                password: panel.password,
                deskNumber: panel.attendantDesk.toString(),
              )).toList(),
            )
          ],
        ),
      ),
    );
  }
}