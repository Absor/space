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
      pc.position.setFrom(tpc.position);
      // TODO rotation + offset
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