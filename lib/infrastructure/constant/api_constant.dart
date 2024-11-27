class ApiConstant{
  ///base url
  static const baseUrl = "https://script.google.com/macros/s/";


  ///path
  // static const reels = "AKfycbz0aL_2jZK3g-r0J037F_d4XfKHlWFShmwx0-fVVwhyUiUcIcT7pipeyrCQzsltaglM/exec";

  static const credentials = r'''
      {
        "type": "service_account",
        "project_id": "funny-reels-df6e4",
        "private_key_id": "2a1f656e32aaf8b5e6d0f4087bc15fdf2ba9578e",
        "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC54rkz9YrN/m9V\nxLjtnc0schRzxeBGEGVYKW7cKDU6+kXuiA07YfvRB8r1fQbiuZc4tAySeneYujmr\nFKCORVYYl+RdGSBROIGNjKI15JQ9NbIaSysWbGjLRKGwjjIGERiCvFV9DILKcaeA\n8jkYHEHmiHKTTuBpUpDfQpaLaOGperS6HjB61WMQqDHfqPI77BHe/OGcA/dACeDr\nPQm1/BgkHUcjASARC6ieGgDhz0P5mu0tHM7oAvJcFtU3ieiJqfnw60gp8u70Ga05\nrYG59MQy2lte4HTGyT/FkVn7IDZh2wZ6jJKwJUi0xDdsNFDlWFNKZC/u5DnCFYd4\nwCwU5xvRAgMBAAECggEAVjQjEEoQJ2yVxDA5VJSoODLlcjUzRzrGTObWDwokeWfk\nM3TrsfzEM5GKGWN0ZION8hFpfSqHORAvuzuTI7da8IfMMzJ6TsBGMFcmSJjq+CHl\nKRVv83Ot+4ol88NVxoN6GvLtMFMzel/PvthWCuzb0OW5QMBFCQLtxWPTfe5TLG09\nQpG8ef8LOyPhyPIWtiPq8KX2WqjfoauIX/hc8HbC6dHC3sXbY+ORauiYfYvGfoxS\nwLensObK7xkECkATe1ISc58zIaD8vpWUzc6e3uf7i/M3B4Fm6gED+dK0C2m34V59\npBn7tgjlfGZhU/PDQCiUzFnKFk+mFvnwmIJmXYZ2EwKBgQDkm3KFpyFEPvOJiRWk\n2aHzCGzSw+aGwaPmigr53LhJifXDacGLZV4OlRrS6bYIEAm1txuQ+3pC072FiEzl\nJ0pxfsVjSmDqz/kjDeXSlgCZJeUgcFg92FGyjMy8LyzIVS1BI0EHZLBCUJb90q8s\n3KQsmjlVSmEt/RZ7/RblPFk5hwKBgQDQKMlq2wTXb5AI0F/7qBYzGXOeBQEQTAj6\nVmhhFTPB/wuOe+Ah9ly3TBukZaw/Lpm+FmcxKIG6xAoxD1ugCMjILHU99B4bRk9E\nmvY2Rtbjx2ObaaQUN2QOdY5m60QQ9edbAsWrICg5AfOSKoYE7qgW7dYsMuCuuxPp\nnTPCHnr15wKBgGFHhMQ7CnzwDNJJ81vjAHda7nQByOcvH3/K3kDVG9avTlWJe0LG\nL/AkovV9Xmiv6nHZKXHYkX4+fDeGeLJKtfL17ykBTZyeQ3YXQ+UIz9hbt9TF+cbX\ndmx0Xer2aCgXltpRFir/PcH6aUY5kTGV8obIWf1hWVkoiZjZahTCSXWhAoGAd3xi\nGb886Tk10Yli/z6993kNn9A5ixRKNwCwi8Gy4xG2nYRH5NbY47KBT325QM9MGwwb\nEeGxjfaH7x9ktdk0/4pdhkGBoqBaUgQtfnxtT3SdnZEnSR9+hLpAEp3LhXzR37EY\nrCEaVZbkLKvSIDSqMfc18EsII+RpCrldA3mhlVMCgYAX+9Oo7vvMVsLe1PuYo57x\n04obr2S71yv3nu80jnpafUG1TH97lEiyPTYrNqwWbNwmP5j6QZ1xkJKg0nt5m2W7\n21009evMT7c7RP5s416+Ftby0c2jqQuvuOR3M8vxWMOHuUl4qystQfEszQ/GnbK4\n7maaS0CpSotF+FbaMKDB9A==\n-----END PRIVATE KEY-----\n",
        "client_email": "firebase-adminsdk-eyfck@funny-reels-df6e4.iam.gserviceaccount.com",
        "client_id": "111912996245920297165",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-eyfck%40funny-reels-df6e4.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      }
  ''';

  static const spreadSheetId = "1LFoQHWUC78vVCuuCeqiL1yfztizLjRFLpeRPuDkiFoY";

  ///Wallpaper Id
  static const trendingSheetId = 1795107104;
  static const animeSheetId = 1224185232;
  static const assassinsCreedSheetId = 388585238;
  static const categoriesSheetId = 1781470428;
  static const futuristicSheetId = 1064624494;
  static const godOfWarSheetId = 1201854847;
  static const liveWallpaperSheetId = 294404834;

  ///Ringtone Id
  static const ringtoneSheetId = 1377233789;

  ///SearchCarouselId
  static const searchCarouselId = 1750808013;

  ///versionCodeId
  static const versionCodeId = 930798743;


}