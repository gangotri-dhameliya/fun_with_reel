import 'package:reels_app/infrastructure/model/ringtone_data_model.dart';
import 'package:reels_app/infrastructure/model/wallpaper_data_model.dart';
import 'package:reels_app/infrastructure/storage/database_helper.dart';


/// set ads in wallpaper and ringtone data list
List<WallpaperDataModel> reelAdsDataList({required List<WallpaperDataModel> wallpaper}){
  List<WallpaperDataModel> wallpaperDataList = [];
  for(int i = 0; i<wallpaper.length;i++){
    if(i%5 == 4){
      wallpaperDataList.add(WallpaperDataModel(image: "",category: "",thumbnail: ""));
      wallpaperDataList.add(wallpaper[i]);
    }else{
      wallpaperDataList.add(wallpaper[i]);
    }
  }
  return wallpaperDataList;
}

List<RingtoneDataModel> ringtoneAdsDataList({required List<RingtoneDataModel> ringtone}){
  List<RingtoneDataModel> ringtoneDataList = [];
  for(int i = 0; i<ringtone.length;i++){
    if(i%5 == 4){
      ringtoneDataList.add(RingtoneDataModel(image: "",name: "",ringtone: ""));
      ringtoneDataList.add(ringtone[i]);
    }else{
      ringtoneDataList.add(ringtone[i]);
    }
  }
  return ringtoneDataList;
}





///get image and video link from google drive
String getImageLink({required String url}){
  String fileId = url.split("/")[5];
  return url.contains("drive.google.com") ? "https://drive.google.com/uc?export=view&id=$fileId" : url;
  // return url.contains("drive.google.com") ? "https://drive.google.com/uc?export=view&id=$fileId" : url;
  // return "https://drive.google.com/uc?export=view&id=$fileId";
}

String getVideoLink({required String url}){
  String fileId = url.split("/")[5];
  return url.contains("drive.google.com") ? "https://drive.google.com/file/d/$fileId/preview" : url;
  // return url.contains("drive.google.com") ? "https://drive.google.com/uc?export=view&id=$fileId" : url;
  // return "https://drive.google.com/uc?export=view&id=$fileId";
}






/// Save wallpaper and ringtones to local storage
Future<List<WallpaperDataModel>> saveWallpaperToLocal(List<WallpaperDataModel> wallpaperDataList) async{
  DatabaseHelper db = DatabaseHelper();
  if(await db.tableIsEmpty() == 0){
    // for (var data in wallpaperDataList) {
    //   db.insertWallpaperFavourites(WallpaperDataModel(image: data.image,thumbnail: data.thumbnail,category: data.category,premium: data.premium,like: 0));
    // }
    return wallpaperDataList;
  } else{
    List<WallpaperDataModel> dataList = await db.getWallpaperFavouritesData();
    List<String> wallpaperSampleDataList = [];
    for(var w in wallpaperDataList){
      wallpaperSampleDataList.add(w.image ?? "");
    }
    for(var d in dataList){
        // print("Favorites DATA =======> ${d.image}");
        if(wallpaperSampleDataList.contains(d.image)){
          wallpaperDataList[wallpaperDataList.indexWhere((element) => element.image == d.image)].like = 1;
        }
    }
    return wallpaperDataList;
    // for(int i = 0;i<wallpaperDataList.length;i++){
    //   if(!wallpaperSampleDataList.contains(wallpaperDataList[i].image ?? "")){
    //     db.insertWallpaperFavourites(WallpaperDataModel(image: wallpaperDataList[i].image ?? "",thumbnail: wallpaperDataList[i].thumbnail ?? "",category: wallpaperDataList[i].category ?? "",premium: wallpaperDataList[i].premium ?? 0,like: 0));
    //   }
    // }
  }

  // List<WallpaperDataModel> wallpapers = await db.getWallpaperFavouritesData();
  // wallpapers.shuffle();
  //
  // return wallpapers;
}

Future<List<RingtoneDataModel>> saveRingtoneToLocal(List<RingtoneDataModel> ringtoneDataList) async{
  DatabaseHelper db = DatabaseHelper();
  if(await db.ringtoneTableIsEmpty() == 0){
    // for (var data in ringtoneDataList) {
    //   db.insertRingtoneFavourites(RingtoneDataModel(image: data.image,name: data.name,ringtone: data.ringtone,premium: data.premium,like: 0));
    // }
    return ringtoneDataList;
  } else{
    List<RingtoneDataModel> dataList = await db.getRingtoneFavouritesData();
    List<String> ringtoneSampleDataList = [];
    for(var w in ringtoneDataList){
      ringtoneSampleDataList.add(w.ringtone ?? "");
    }

    for(var d in dataList){
      // print("Favorites DATA =======> ${d.image}");
      if(ringtoneSampleDataList.contains(d.ringtone)){
        ringtoneDataList[ringtoneDataList.indexWhere((element) => element.ringtone == d.ringtone)].like = 1;
      }
    }
    return ringtoneDataList;
    // for(int i = 0;i<ringtoneDataList.length;i++){
    //   if(!ringtoneSampleDataList.contains(ringtoneDataList[i].ringtone ?? "")){
    //     db.insertRingtoneFavourites(RingtoneDataModel(image: ringtoneDataList[i].image,name: ringtoneDataList[i].name ?? "",ringtone: ringtoneDataList[i].ringtone ?? "",premium: ringtoneDataList[i].premium ?? 0,like: 0));
    //   }
    // }
  }

  // List<RingtoneDataModel> ringtones = await db.getRingtoneFavouritesData();
  // ringtones.shuffle();
  //
  // return ringtones;
}




///get duration of ringtone
String getDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
  return "$twoDigitMinutes:$twoDigitSeconds";
}


///get formatted date
String getDate(DateTime date) {
  return "${date.day}-${date.month}-${date.year}";
}
