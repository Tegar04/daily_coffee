/// App-owned, normalized JPEG candidate. Never a provider/cache URI.
final class ManagedImage {
  const ManagedImage({
    required this.id,
    required this.localPath,
    required this.width,
    required this.height,
    required this.byteSize,
    required this.source,
  });
  final String id;
  final String localPath;
  final int width;
  final int height;
  final int byteSize;
  final String source;
  String get thumbnailPath => '$localPath.thumb.jpg';
  Map<String, Object> toJson() => {
    'id': id,
    'path': localPath,
    'width': width,
    'height': height,
    'bytes': byteSize,
    'source': source,
  };
  factory ManagedImage.fromJson(Map<String, dynamic> json) => ManagedImage(
    id: json['id'] as String,
    localPath: json['path'] as String,
    width: json['width'] as int,
    height: json['height'] as int,
    byteSize: json['bytes'] as int,
    source: json['source'] as String,
  );
}
