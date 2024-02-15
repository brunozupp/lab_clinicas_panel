import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_panel/src/pages/panel/panel_controller.dart';
import 'package:lab_clinicas_panel/src/pages/panel/widgets/panel_main_widget.dart';

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
                SizedBox(
                  width: sizeOf.width * 0.4,
                  child: const PanelMainWidget(
                    passwordLabel: "Senha anterior",
                    password: "BG5898",
                    deskNumber: "03",
                    labelColor: LabClinicasTheme.blueColor,
                    buttonColor: LabClinicasTheme.orangeColor,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: sizeOf.width * 0.4,
                  child: const PanelMainWidget(
                    passwordLabel: "Chamando senha",
                    password: "BG5898",
                    deskNumber: "03",
                    labelColor: LabClinicasTheme.orangeColor,
                    buttonColor: LabClinicasTheme.blueColor,
                  ),
                ),
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
            const Wrap(
              spacing: 10,
              runSpacing: 10,
              runAlignment: WrapAlignment.center,
              children: [
                PasswordTileWidget(),
                PasswordTileWidget(),
                PasswordTileWidget(),
                PasswordTileWidget(),
                PasswordTileWidget(),
                PasswordTileWidget(),
                PasswordTileWidget(),
                PasswordTileWidget(),
              ],
            )
          ],
        ),
      ),
    );
  }
}