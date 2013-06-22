part of space;

class WeaponTriggeringSystem implements System {
  
  bool enabled;
  int priority;
  
  List<Entity> _repeatingEntities;
    
  WeaponTriggeringSystem() {
    _repeatingEntities = new List<Entity>();
  }
    
  void process(num timeDelta) {
    for (Entity entity in _repeatingEntities) {
      RepeatingWeaponComponent rwc = entity.getComponent(RepeatingWeaponComponent);
      rwc.timeSinceLast += timeDelta;
      if (rwc.timeSinceLast > rwc.timeBetweenShots) {
        rwc.timeSinceLast -= rwc.timeBetweenShots;
        WeaponTriggerComponent wtc = entity.getComponent(WeaponTriggerComponent);
        wtc.triggered = true;
      }
    }
  }
    
  void attachWorld(World world) {
  }
  
  void detachWorld() {
  }
  
  void entityActivation(Entity entity) {
    if (entity.hasComponent(RepeatingWeaponComponent) &&
        entity.hasComponent(WeaponTriggerComponent)) {
      _repeatingEntities.add(entity);
    }
  }
  
  void entityDeactivation(Entity entity) {
    _repeatingEntities.remove(entity);
  }
}