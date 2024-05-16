import 'package:konsuldoc/domain/entities/change_channel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data_change_listener_provider.g.dart';

@riverpod
ChangeChannel changeChannel(ChangeChannelRef ref, ChangeChannel channel) {
  ref.onDispose(channel.dispose);

  return channel;
}
