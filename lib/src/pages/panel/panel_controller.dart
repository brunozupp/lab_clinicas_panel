import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_panel/src/models/panel_checkin_model.dart';
import 'package:lab_clinicas_panel/src/repositories/panel_checkin/i_panel_checkin_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class PanelController with MessageStateMixin {
  
  final IPanelCheckinRepository _panelCheckinRepository;

  PanelController({
    required IPanelCheckinRepository panelCheckinRepository,
  }) : _panelCheckinRepository = panelCheckinRepository;

  Function? _socketDispose;

  final painelData = listSignal<PanelCheckinModel>([]);

  Connect? _painelConnect;

  void listenerPanel() {

    final (:channel, :dispose) = _panelCheckinRepository.openChannelSocket();
  
    _socketDispose = dispose;

    // Esse connect seria um Adapter, que vai conectar minha Stream com o minha variável Signal
    _painelConnect = connect(painelData);

    final painelStream = _panelCheckinRepository.getTodayPanel(channel);

    _painelConnect!.from(painelStream);
  }

  void dispose() {

    _painelConnect?.dispose();

    if(_socketDispose != null) {
      _socketDispose!();
    }
  }
}