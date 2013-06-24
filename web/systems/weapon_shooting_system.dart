part of space;

class WeaponShootingSystem implements System {
  
  bool enabled;
  int priority;
  
  World _world;
  List<Entity> _repeatingEntities;
    
  WeaponShootingSystem() {
    _repeatingEntities = new List<Entity>();
  }
    
  void process(num timeDelta) {
    for (Entity entity in _repeatingEntities) {
      WeaponTriggerComponent wtc = entity.getComponent(WeaponTriggerComponent);
      if (wtc.triggered) {
        wtc.triggered = false;
        Entity bullet = _world.createEntity(idManager.getFreeId());
        componentAttacher.attachBulletComponents(bullet);
        _world.activateEntity(bullet.id);
      }
    }
  }
    
  void attachWorld(World world) {
    _world = world;
  }
  
  void detachWorld() {
    _world = null;
  }
  
  void entityActivation(Entity entity) {
    if (entity.hasComponent(WeaponTriggerComponent) &&
        entity.hasComponent(RepeatingWeaponComponent)) {
      _repeatingEntities.add(entity);
    }
  }
  
  void entityDeactivation(Entity entity) {
    _repeatingEntities.remove(entity);
  }
}