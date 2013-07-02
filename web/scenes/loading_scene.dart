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
    Map jsonData = parse(jsonString);
    for (String key in jsonData.keys) {
      _toLoad += jsonData[key].length;
    }
    for (String key in jsonData.keys) {
      // load and stuff
      switch (key) {
        case "images":
          _loadImages(jsonData[key]);
          break;
      }
    }
  }
  
  void _loadImages(List filenames) {
    for (String filename in filenames) {
      ImageElement img = new ImageElement();
      img.onLoad.listen((i) => _loadingFinished());
      img.src = filename;
    }
  }
  
  void _loadingFinished() {
    _loaded++;
    print(_loaded);
    if (_loaded == _toLoad) {
      
    }
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
    canvasManager.context.font = px.toString() + "px Arial";
    canvasManager.context.fillStyle = "white";
    canvasManager.context.fillText("$_loaded/$_toLoad", 305, 50);
    canvasManager.context.restore();
  }
  
  void start() {
    
  }
  
  void stop() {
    
  }
}