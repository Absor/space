part of space;

class CollisionSystem implements System {
  
  bool enabled;
  int priority;
  
  List<Entity> _collidingEntities;
    
  CollisionSystem() {
    _collidingEntities = new List<Entity>();
  }
    
  void process(num timeDelta) {
    for (Entity entity in _collidingEntities) {
      
    }
  }
    
  void attachWorld(World world) {
  }
  
  void detachWorld() {
  }
  
  void entityActivation(Entity entity) {
    if (entity.hasComponent(CollisionComponent) &&
        entity.hasComponent(PositionComponent)) {
      _collidingEntities.add(entity);
    }
  }
  
  void entityDeactivation(Entity entity) {
    _collidingEntities.remove(entity);
  }
}