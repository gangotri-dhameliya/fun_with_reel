class CommonUtils{
  static String getImageLink({required String url}){
    String fileId = url.split("/")[5];
    return url.contains("drive.google.com") ? "https://drive.google.com/uc?export=view&id=$fileId" : url;
    // return url.contains("drive.google.com") ? "https://drive.google.com/uc?export=view&id=$fileId" : url;
    // return "https://drive.google.com/uc?export=view&id=$fileId";
  }
}