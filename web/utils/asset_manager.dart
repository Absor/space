part of space;

class AssetManager {
  
  Map<String, Map<String, dynamic>> _assetGroups;
  Map<String, List<dynamic>> _baseGroups;
  
  AssetManager() {
    _assetGroups = new HashMap<String, Map<String, dynamic>>();
    _baseGroups = new HashMap<String, List<dynamic>>();
  }
  
  dynamic getAsset(String group, String assetName) {
    if (!_assetGroups.containsKey(group)) return null;
    print("served $group $assetName");
    return _assetGroups[group][assetName];
  }
  
  void addAsset(String group, String assetName, dynamic asset) {
    if (!_assetGroups.containsKey(group)) {
      _assetGroups[group] = new HashMap<String, dynamic>();
    }
    print("added $group $assetName");
    _assetGroups[group][assetName] = asset;
  }
  
  void addBase(String group, dynamic base) {
    if (!_baseGroups.containsKey(group)) {
      _baseGroups[group] = new List<dynamic>();
    }
    print("added base to group $group");
    _baseGroups[group].add(base);
  }
  
  List<dynamic> getBaseGroup(String group) {
    print("served basegroup $group");
    return _baseGroups[group];
  }
}