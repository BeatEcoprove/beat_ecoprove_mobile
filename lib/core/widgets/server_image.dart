import 'package:flutter/material.dart';
import 'package:beat_ecoprove/core/config/server_config.dart';

class ServerImage implements ImageProvider<NetworkImage> {
  final NetworkImage _provider;

  ServerImage(String path)
      : _provider =
            NetworkImage(Uri.parse('${ServerConfig.blobUrl}/$path').toString());

  @override
  ImageStream createStream(ImageConfiguration configuration) {
    return _provider.createStream(configuration);
  }

  @override
  Future<bool> evict(
      {ImageCache? cache,
      ImageConfiguration configuration = ImageConfiguration.empty}) {
    return _provider.evict(configuration: configuration, cache: cache);
  }

  // @override
  // ImageStreamCompleter load(NetworkImage key, DecoderCallback decode) {
  //   return _provider.load(key, decode);
  // }

  @override
  ImageStreamCompleter loadBuffer(
      NetworkImage key, DecoderBufferCallback decode) {
    return _provider.loadBuffer(key, decode);
  }

  @override
  ImageStreamCompleter loadImage(
      NetworkImage key, ImageDecoderCallback decode) {
    return _provider.loadImage(key, decode);
  }

  @override
  Future<ImageCacheStatus?> obtainCacheStatus(
      {required ImageConfiguration configuration,
      ImageErrorListener? handleError}) {
    return _provider.obtainCacheStatus(configuration: configuration);
  }

  @override
  Future<NetworkImage> obtainKey(ImageConfiguration configuration) {
    return _provider.obtainKey(configuration);
  }

  @override
  ImageStream resolve(ImageConfiguration configuration) {
    return _provider.resolve(configuration);
  }

  @override
  void resolveStreamForKey(ImageConfiguration configuration, ImageStream stream,
      NetworkImage key, ImageErrorListener handleError) {
    return _provider.resolveStreamForKey(
        configuration, stream, key, handleError);
  }
}
