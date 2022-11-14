class Folder {
  final String path;
  bool hasContent;

  Folder({required this.path, this.hasContent = false});

  Folder.fromJson(Map<String, dynamic> json)
      : path = json['path'] as String,
        hasContent = json['has_content'] as bool;

  Map<String, dynamic> toJson() => {
        'path': path,
        'has_content': hasContent,
      };
}
