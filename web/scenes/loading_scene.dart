part of space;

class LoadingScene implements Scene {
  
  int _loaded;
  int _toLoad;
    
  LoadingScene() {
    _loaded = 0;
    _toLoad = 0;
    HttpRequest.getString("assets/all_files.json").then(_loadAllFiles);
  }
  
  void _loadAllFiles(var jsonString) {
    Map jsonData = new JsonObject.fromJsonString(jsonString);
    // count how many
    for (String key in jsonData.keys) {
      _toLoad += jsonData[key].length;
    }
    // load
    _loadImages(jsonData.images);
    _loadSounds(jsonData.sounds);
    _loadJSON(jsonData.jsonFiles);
  }
  
  void _loadImages(List filenames) {
    for (String filename in filenames) {
      ImageElement img = new ImageElement();
      img.onLoad.listen((i) => _loadingFinished());
      img.src = filename;
      assetManager.addAsset("image", path.basename(filename), img);
    }
  }
  
  void _loadSounds(List filenames) {
    for (String filename in filenames) {
      // TODO
      _loadingFinished();
    }
  }
  
  void _loadJSON(List filenames) {
    for (String filename in filenames) {
      HttpRequest.getString(filename).then((String jsonString) {
        var jsonData = new JsonObject.fromJsonString(jsonString);
        assetManager.addAsset("json", path.basename(filename), jsonData);
        _loadingFinished();
      });
    }
  }
  
  void _loadingFinished() {
    _loaded++;
    if (_loaded == _toLoad) {
      // when loaded setup components and continue to game
      Future.wait([_setupImageComponents(), _setupBases()]).then((l) {
        sceneManager.addScene("game", new GameScene());
        sceneManager.changeScene("game");
      });
    }
  }
  
  Future _setupImageComponents() {
    Completer completer = new Completer();
    
    // texturepacker
    var data = assetManager.getAsset("json", "image_components.json");
    ImageElement image = assetManager.getAsset("image", data.meta.image);
    for (var imageData in data.frames) {
      _addImageComponent(image, imageData);
    }
    
    // additional
    var extraData = assetManager.getAsset("json", "image_components_extras.json");
    for (var imageData in extraData) {
      ImageElement extraImage = assetManager.getAsset("image", imageData.image);
      _addImageComponent(extraImage, imageData);
    }
    
    // offsets
    var offsetDatas = assetManager.getAsset("json", "image_components_offsets.json");
    for (var offsetData in offsetDatas) {
      ImageComponent ic = assetManager.getAsset("image_component", offsetData.filename);
      ic.xOffset += offsetData.offset.x;
      ic.yOffset += offsetData.offset.y;
    }
    
    completer.complete();
    
    return completer.future;
  }
  
  void _addImageComponent(ImageElement image, var imageData) {
    ImageComponent ic = new ImageComponent();
    ic.source = image;
    ic.sourceWidth = imageData.frame.w;
    ic.sourceHeight = imageData.frame.h;
    ic.sourceX = imageData.frame.x;
    ic.sourceY = imageData.frame.y;
    ic.xOffset = -ic.sourceWidth / 2;
    ic.yOffset = -ic.sourceHeight / 2;
    if (imageData.trimmed) {
      ic.xOffset -= (imageData.sourceSize.w - ic.sourceWidth) / 2 - imageData.spriteSourceSize.x;
      ic.yOffset -= (imageData.sourceSize.h - ic.sourceHeight) / 2 - imageData.spriteSourceSize.y;
    }
    assetManager.addAsset("image_component", imageData.filename, ic);
  }
  
  Future _setupBases() {
    Completer completer = new Completer();
    
    for (JsonObject shipBaseObject in assetManager.getAsset("json", "ship_bases.json")) {
      ShipBase shipBase = new ShipBase(shipBaseObject);
      assetManager.addBase("ship", shipBase);
    }
    
    completer.complete();
    
    return completer.future;
  }
  
  void draw() {
    if (_toLoad == 0) return;
    canvasManager.clearCanvas();
    // Loading bar
    canvasManager.context.save();
    canvasManager.context.translate(canvasManager.canvasMiddlePoint.x,
        canvasManager.canvasMiddlePoint.y);
    canvasManager.context.scale(canvasManager.drawScaler, canvasManager.drawScaler);
    canvasManager.context.fillStyle = "white";
    canvasManager.context.fillRect(-300, -50, 600, 100);
    canvasManager.context.fillStyle = "black";
    canvasManager.context.fillRect(-290, -40, 580, 80);
    canvasManager.context.fillStyle = "white";
    num percentage = _loaded / _toLoad;
    canvasManager.context.fillRect(-285, -35, percentage*570, 70);
    // Text
    int px = (canvasManager.drawScaler * 30).ceil();
    canvasManager.context.font = px.toString() + "px Impact";
    canvasManager.context.fillStyle = "white";
    canvasManager.context.fillText("$_loaded/$_toLoad", 305, 50);
    canvasManager.context.restore();
  }
  
  void start() {
    
  }
  
  void stop() {
    
  }
}