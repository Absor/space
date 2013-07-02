part of space;

class WeaponShootingSystem implements System {
  
  bool enabled;
  int priority;
  
  World _world;
  List<Entity> _singleDirectionWeapons;
    
  WeaponShootingSystem() {
    _singleDirectionWeapons = new List<Entity>();
  }
    
  void process(num timeDelta) {
    for (Entity weapon in _singleDirectionWeapons) {
      WeaponTriggerComponent wtc = weapon.getComponent(WeaponTriggerComponent);
      if (wtc.triggered) {
        RotationComponent rc = weapon.getComponent(RotationComponent);
        WeaponAttributesComponent wac = weapon.getComponent(WeaponAttributesComponent);
        Entity bullet = _world.createEntity(idManager.getFreeId());
        componentAttacher.attachBulletComponents(bullet,
            (wac.startVelocity*sin(rc.angleInRadians)).toDouble(),
            (wac.startVelocity*cos(rc.angleInRadians)).toDouble());
        _world.activateEntity(bullet.id);
      }
      wtc.triggered = true;
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
        entity.hasComponent(SingleDirectionWeaponComponent) &&
        entity.hasComponent(RotationComponent) &&
        entity.hasComponent(WeaponAttributesComponent)) {
      _singleDirectionWeapons.add(entity);
    }
  }
  
  void entityDeactivation(Entity entity) {
    _singleDirectionWeapons.remove(entity);
  }
}