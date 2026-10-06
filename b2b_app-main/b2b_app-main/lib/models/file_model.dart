class FileModel {

  String? id;
  String? mimeType;
  String? filename;
  String? url;


  FileModel({required this.id, required this.mimeType, required this.filename, required this.url});


  factory FileModel.fromJson(Map<String, dynamic> json){
    return  FileModel(id: json['id'] ?? "",
     mimeType:json ['mimeType'], 
     filename: json['filename'],
      url: json['url']);
  }

  Map<String, dynamic> toJsonForLocalStorage() {
    return {
      "id": id,
      "mimeType" : mimeType,
     "filename" :filename,
     "url": url,
    };
  }

}