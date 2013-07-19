part of space;

class ShipBase {
  
  String shipName;
  
  ShipBase(JsonObject jsonData) {
    shipName = jsonData.name;
  }
}