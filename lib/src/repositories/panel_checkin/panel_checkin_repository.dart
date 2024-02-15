import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_panel/src/core/env.dart';
import 'package:lab_clinicas_panel/src/models/panel_checkin_model.dart';
import 'package:lab_clinicas_panel/src/repositories/panel_checkin/i_panel_checkin_repository.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PanelCheckinRepository implements IPanelCheckinRepository{
  
  final RestClient _restClient;

  PanelCheckinRepository({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Stream<List<PanelCheckinModel>> getTodayPanel(WebSocketChannel channel)  async* {
    
    yield await requestData();

    yield* channel.stream.asyncMap((_) async => requestData());
  }

  @override
  ({WebSocketChannel channel, Function dispose}) openChannelSocket() {
    
    final channel = WebSocketChannel.connect(Uri.parse("${Env.wsBackendBaseUrl}?tables=painelCheckin"));

    return (
      channel: channel, 
      dispose: () {
        // Sink - enviar dados para o servidor
        // Stream - para extrair os dados
        channel.sink.close();
      },
    );
  }

  Future<List<PanelCheckinModel>> requestData() async {

    final dateFormat = DateFormat("y-MM-d");

    final Response(:List data) = await _restClient.auth.get("/painelCheckin", queryParameters: {
      "time_called": dateFormat.format(DateTime.now()),
    });

    return data.reversed
        .take(7)
        .map((e) => PanelCheckinModel.fromJson(e))
        .toList();
  }
}