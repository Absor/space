part of space;

class DebuggingSystem implements System {
    
  bool enabled;
  int priority;
  
  List<Entity> _velocityEntities;
  List<Entity> _wanderingEntities;
  Entity _centerEntity;
  
  bool _drawVelocities;
  bool _drawWandering;
    
  DebuggingSystem() {
    _velocityEntities = new List<Entity>();
    _wanderingEntities = new List<Entity>();
    
    _drawVelocities = true;
    _drawWandering = true;
  }
  
  void process(num timeDelta) {
    if (_centerEntity == null) return;
    PositionComponent cPC = _centerEntity.getComponent(PositionComponent);
    Vector2 centerPosition = cPC.position;
    if (_drawVelocities) {
      for (Entity entity in _velocityEntities) {
        PositionComponent pc = entity.getComponent(PositionComponent);
        Vector2 position = pc.position;
        VelocityComponent vc = entity.getComponent(VelocityComponent);
        canvasManager.context.save();
        num distanceScaler = canvasManager.drawScaler * settings.pixelsPerMeter;
        canvasManager.context.translate(
            (position.x - centerPosition.x) * distanceScaler + canvasManager.canvasMiddlePoint.x,
            (position.y - centerPosition.y) * distanceScaler + canvasManager.canvasMiddlePoint.y);
        canvasManager.context.scale(distanceScaler, distanceScaler);
        canvasManager.context.strokeStyle = "red";
        canvasManager.context.lineWidth = 5;
        canvasManager.context.beginPath();
        canvasManager.context.moveTo(0, 0);
        canvasManager.context.lineTo(vc.velocity.x, vc.velocity.y);
        canvasManager.context.closePath();
        canvasManager.context.stroke();
        canvasManager.context.restore();
      }
    }
    if (_drawWandering) {
      for (Entity entity in _wanderingEntities) {
        WandererComponent wc = entity.getComponent(WandererComponent);
        PositionComponent pc = entity.getComponent(PositionComponent);
        Vector2 position = pc.position;
        VelocityComponent vc = entity.getComponent(VelocityComponent);
        AccelerationComponent ac = entity.getComponent(AccelerationComponent);
        canvasManager.context.save();
        num distanceScaler = canvasManager.drawScaler * settings.pixelsPerMeter;
        canvasManager.context.translate(
            (position.x - centerPosition.x + vc.velocity.x) * distanceScaler + canvasManager.canvasMiddlePoint.x,
            (position.y - centerPosition.y + vc.velocity.y) * distanceScaler + canvasManager.canvasMiddlePoint.y);
        canvasManager.context.scale(distanceScaler, distanceScaler);
        canvasManager.context.strokeStyle = "green";
        canvasManager.context.lineWidth = 5;
        canvasManager.context.beginPath();
        canvasManager.context.arc(0, 0, vc.maxVelocity, 0, PI*2);
        canvasManager.context.closePath();
        canvasManager.context.stroke();
        canvasManager.context.beginPath();
        canvasManager.context.moveTo(0, 0);
        canvasManager.context.lineTo(vc.maxVelocity * cos(wc.wanderAngle),
            vc.maxVelocity * sin(wc.wanderAngle));
        canvasManager.context.closePath();
        canvasManager.context.stroke();
        canvasManager.context.restore();
      }
    }
  }
    
  void attachWorld(World world) {
  }
  
  void detachWorld() {
  }
  
  void entityActivation(Entity entity) {
    if (entity.hasComponent(CameraCenteringComponent)) {
      _centerEntity = entity;
    }
    if (entity.hasComponent(VelocityComponent) &&
        entity.hasComponent(PositionComponent)) {
      _velocityEntities.add(entity);
    }
    if (entity.hasComponent(VelocityComponent) &&
        entity.hasComponent(PositionComponent) &&
        entity.hasComponent(WandererComponent)) {
      _wanderingEntities.add(entity);
    }
  }
  
  void entityDeactivation(Entity entity) {
    if (entity == _centerEntity) _centerEntity = null;
    _velocityEntities.remove(entity);
    _wanderingEntities.remove(entity);
  }
}