part of space;

class GameSettings {
  num screenWidth = 1024;
  num screenHeight = 640;
  
  num pixelsPerMeter = 1/4;
  
  num getScreenRatio() => screenWidth / screenHeight;
  
  bool debug = true;
}