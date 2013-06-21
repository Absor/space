part of space;

class FollowerSystem implements System {
  
  bool enabled;
  int priority;
  
  World _world;
  List<Entity> _followingEntities;
    
  FollowerSystem() {
    _followingEntities = new List<Entity>();
  }
    
  void process(num timeDelta) {
    for (Entity entity in _followingEntities) {
      FollowerComponent fc = entity.getComponent(FollowerComponent);
      if (fc.targetId != null) {
        PositionComponent tpc = _world.getEntityById(fc.targetId).getComponent(PositionComponent);
        fc.targetPosition.setFrom(tpc.position);
      }
      Vector2 targetPosition = fc.targetPosition;
      AccelerationComponent ac = entity.getComponent(AccelerationComponent);
      VelocityComponent vc = entity.getComponent(VelocityComponent);
      PositionComponent pc = entity.getComponent(PositionComponent);
      Vector2 position = pc.position;
      // desired velocity vector
      Vector2 desired = targetPosition - position;
      // move with full velocity
      desired.normalize().scale(vc.maxVelocity.toDouble());
      desired.sub(vc.velocity);
      // limit force
      if (desired.length > ac.maxForce) {
        desired.normalize().scale(ac.maxForce.toDouble());
      }
      ac.acceleration.add(desired);
    }
  }
    
  void attachWorld(World world) {
    _world = world;
  }
  
  void detachWorld() {
    _world = null;
  }
  
  void entityActivation(Entity entity) {
    if (entity.hasComponent(FollowerComponent) &&
        entity.hasComponent(AccelerationComponent) &&
        entity.hasComponent(VelocityComponent) &&
        entity.hasComponent(PositionComponent)) {
      _followingEntities.add(entity);
    }
  }
  
  void entityDeactivation(Entity entity) {
    _followingEntities.remove(entity);
  }
}