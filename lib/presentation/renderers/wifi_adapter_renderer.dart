import 'package:flutter/material.dart';
import 'package:flutter_win32_examples/domain/wifi_adapter.dart';
import 'package:flutter_win32_examples/presentation/renderers/irenderable.dart';
import 'package:flutter_win32_examples/presentation/renderers/wifi_connection_renderer.dart';

class WiFiAdapterRenderer extends IRenderable<WiFiAdapter> {
  WiFiAdapterRenderer(super.model);

  @override
  Widget render(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.amberAccent.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Adapter: ${model.desc}'),
          Text('GUID: ${model.guid}'),
          const SizedBox(
            height: 16,
          ),
          ...model.connections
              .map((connection) =>
                  WiFiConnectionRenderer(connection).render(context))
              .toList(),
        ],
      ),
    );
  }
}
