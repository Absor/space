part of space;

class WandererSystem implements System {
  
  bool enabled;
  int priority;
  
  List<Entity> _wanderingEntities;
    
  WandererSystem() {
    _wanderingEntities = new List<Entity>();
  }
    
  void process(num timeDelta) {
    for (Entity entity in _wanderingEntities) {
      WandererComponent wc = entity.getComponent(WandererComponent);
      AccelerationComponent ac = entity.getComponent(AccelerationComponent);
      VelocityComponent vc = entity.getComponent(VelocityComponent);
      PositionComponent pc = entity.getComponent(PositionComponent);
      // randomize new angle
      wc.wanderAngle += new Random().nextDouble() * wc.wanderChange - wc.wanderChange * 0.5;
      // calculate wander force for random direction with max velocity
      Vector2 wanderForce = new Vector2(vc.maxVelocity * cos(wc.wanderAngle),
          vc.maxVelocity * sin(wc.wanderAngle));
      // calculate desired force
      Vector2 desired = vc.velocity.clone().add(wanderForce);
      // limit force
      if (desired.length > ac.maxForce) {
        desired.normalize().scale(ac.maxForce.toDouble());
      }
      ac.acceleration.add(desired);
    }
  }
    
  void attachWorld(World world) {
  }
  
  void detachWorld() {
  }
  
  void entityActivation(Entity entity) {
    if (entity.hasComponent(WandererComponent) &&
        entity.hasComponent(AccelerationComponent) &&
        entity.hasComponent(VelocityComponent) &&
        entity.hasComponent(PositionComponent)) {
      _wanderingEntities.add(entity);
    }
  }
  
  void entityDeactivation(Entity entity) {
    _wanderingEntities.remove(entity);
  }
}