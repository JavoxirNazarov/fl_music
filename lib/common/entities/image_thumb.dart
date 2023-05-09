class ImageThumb {
  final String url;
  final int height;
  final int width;

  const ImageThumb(
      {required this.height, required this.width, required this.url});

  factory ImageThumb.fromJson(Map<String, dynamic> json) => ImageThumb(
        height: json['height'],
        width: json['width'],
        url: json['url'],
      );
}
