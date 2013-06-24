part of space;

class CollisionSystem implements System {
  
  bool enabled;
  int priority;
  
  Entity _player;
  List<Entity> _enemies;
  List<Entity> _playerShots;
  List<Entity> _enemyShots;
    
  CollisionSystem() {
    _enemies = new List<Entity>();
    _playerShots = new List<Entity>();
    _enemyShots = new List<Entity>();
  }
    
  void process(num timeDelta) {
    if (_player == null) return;
    for (Entity enemy in _enemies) {
      for (Entity playerShot in _playerShots) {
        
      }
    }
    
    for (Entity enemyShot in _enemyShots) {
      
    }
  }
    
  void attachWorld(World world) {
  }
  
  void detachWorld() {
  }
  
  void entityActivation(Entity entity) {
    if (entity.hasComponent(CollisionComponent) &&
        entity.hasComponent(PositionComponent)) {
      _enemies.add(entity);
    }
  }
  
  void entityDeactivation(Entity entity) {
    _enemies.remove(entity);
  }
}