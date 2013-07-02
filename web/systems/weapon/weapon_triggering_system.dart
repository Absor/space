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
      WeaponTriggerComponent wtc = entity.getComponent(WeaponTriggerComponent);
      if (rwc.timeSinceLast > rwc.timeBetweenShots) {
        rwc.timeSinceLast -= rwc.timeBetweenShots;
        continue;
      }
      wtc.triggered = false;
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