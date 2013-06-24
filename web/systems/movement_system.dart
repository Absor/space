part of space;

class MovementSystem implements System {
  
  bool enabled;
  int priority;
  
  List<Entity> _movingEntities;
    
  MovementSystem() {
    _movingEntities = new List<Entity>();
  }
  
  void process(num timeDelta) {
    num timeInSeconds = timeDelta / 1000;
    for (Entity entity in _movingEntities) {
      AccelerationComponent ac = entity.getComponent(AccelerationComponent);
      VelocityComponent vc = entity.getComponent(VelocityComponent);
      PositionComponent pc = entity.getComponent(PositionComponent);
      // apply acceleration
      vc.velocity.add(ac.acceleration * timeInSeconds);
      // limit velocity
      if (vc.velocity.length > vc.maxVelocity) {
        vc.velocity.normalize().scale(vc.maxVelocity.toDouble());
      }
      // apply velocity
      pc.position.add(vc.velocity * timeInSeconds);
      // reset acceleration
      ac.acceleration.setZero();
      if (vc.velocity.length != 0 && entity.hasComponent(RotationComponent)) {
        RotationComponent rc = entity.getComponent(RotationComponent);
        rc.angleInRadians = atan2(vc.velocity.x, -vc.velocity.y);
      }
    }
  }
    
  void attachWorld(World world) {
  }
  
  void detachWorld() {
  }
  
  void entityActivation(Entity entity) {
    if (entity.hasComponent(PositionComponent) &&
        entity.hasComponent(VelocityComponent) &&
        entity.hasComponent(AccelerationComponent)) {
      _movingEntities.add(entity);
    }
  }
  
  void entityDeactivation(Entity entity) {
    _movingEntities.remove(entity);
  }
}