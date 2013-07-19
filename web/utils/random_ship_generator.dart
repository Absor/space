part of space;

class RandomShipGenerator {
  int maxTurrets;
  int minTurrets;
  
  RandomShipGenerator() {
    for(var shipBase in assetManager.getBaseGroup("ship")) {
      print("shipBase");
    }
  }
  
  void attachRandomShipComponents(Entity entity) {
    
  }
}