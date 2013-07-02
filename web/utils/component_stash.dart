part of space;

class ComponentStash {
  
  Map<String, Component> _components;
  
  ComponentStash() {
    _components = new HashMap<String, Component>();
  }
  
  Component getComponent(String name) {
    return _components[name];
  }
  
  void addComponent(String name, Component component) {
    _components[name] = component;
  }
}