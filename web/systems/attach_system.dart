part of space;

class AttachSystem implements System {
  
  bool enabled;
  int priority;
  
  World _world;
  List<Entity> _attachedEntities;
    
  AttachSystem() {
    _attachedEntities = new List<Entity>();
  }
    
  void process(num timeDelta) {
    for (Entity entity in _attachedEntities) {
      AttachComponent ac = entity.getComponent(AttachComponent);
      Entity targetEntity = _world.getEntityById(ac.targetId);
      PositionComponent tpc = targetEntity.getComponent(PositionComponent);
      if (tpc == null) continue;
      PositionComponent pc = entity.getComponent(PositionComponent);
      // position
      pc.position.setFrom(tpc.position);
      // rotation + offset
      Vector2 offset;
      if (targetEntity.hasComponent(RotationComponent)) {
        RotationComponent rc = targetEntity.getComponent(RotationComponent);
        num sinAngle = sin(rc.angleInRadians);
        num cosAngle = cos(rc.angleInRadians);
        offset = new Vector2(
            ac.offset.x * cosAngle - ac.offset.y * sinAngle,
            ac.offset.x * sinAngle + ac.offset.y * cosAngle);
      } else {
        offset = ac.offset;
      }          
      pc.position.add(offset);
    }
  }
    
  void attachWorld(World world) {
    _world = world;
  }
  
  void detachWorld() {
    _world = null;
  }
  
  void entityActivation(Entity entity) {
    if (entity.hasComponent(AttachComponent) &&
        entity.hasComponent(PositionComponent)) {
      _attachedEntities.add(entity);
    }
  }
  
  void entityDeactivation(Entity entity) {
    _attachedEntities.remove(entity);
  }
}