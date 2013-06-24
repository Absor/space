part of space;

class DebuggingSystem implements System {
    
  bool enabled;
  int priority;
  
  List<Entity> _velocityEntities;
  List<Entity> _wanderingEntities;
  List<Entity> _pathEntities;
  List<Entity> _collisionEntities;
  Entity _centerEntity;
  int _entityCount;
  
  bool _drawVelocities;
  bool _drawWandering;
  bool _drawPaths;
  bool _drawCollision;
    
  DebuggingSystem() {
    _entityCount = 0;
    _velocityEntities = new List<Entity>();
    _wanderingEntities = new List<Entity>();
    _pathEntities = new List<Entity>();
    _collisionEntities = new List<Entity>();
    
    _drawVelocities = true;
    _drawWandering = true;
    _drawPaths = true;
    _drawCollision = true;
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
    if (_drawPaths) {
      for (Entity entity in _pathEntities) {
        PathFollowerComponent pfc = entity.getComponent(PathFollowerComponent);
        canvasManager.context.save();
        num distanceScaler = canvasManager.drawScaler * settings.pixelsPerMeter;
        canvasManager.context.translate(
            (-centerPosition.x) * distanceScaler + canvasManager.canvasMiddlePoint.x,
            (-centerPosition.y) * distanceScaler + canvasManager.canvasMiddlePoint.y);
        canvasManager.context.scale(distanceScaler, distanceScaler);
        canvasManager.context.strokeStyle = "yellow";
        canvasManager.context.lineWidth = 5;
        canvasManager.context.beginPath();
        canvasManager.context.moveTo(pfc.pathPoints[0].x, pfc.pathPoints[0].y);
        for (int i = 1; i < pfc.pathPoints.length - 1; i++) {
          canvasManager.context.lineTo(pfc.pathPoints[i].x, pfc.pathPoints[i].y);
        }
        canvasManager.context.lineTo(pfc.pathPoints[0].x, pfc.pathPoints[0].y);
        canvasManager.context.closePath();
        canvasManager.context.stroke();
        canvasManager.context.restore();
      }
    }
    if (_drawCollision) {
      for (Entity entity in _collisionEntities) {
        CollisionComponent cc = entity.getComponent(CollisionComponent);
        PositionComponent pc = entity.getComponent(PositionComponent);
        Vector2 position = pc.position;
        canvasManager.context.save();
        num distanceScaler = canvasManager.drawScaler * settings.pixelsPerMeter;
        canvasManager.context.translate(
            (position.x - centerPosition.x) * distanceScaler + canvasManager.canvasMiddlePoint.x,
            (position.y - centerPosition.y) * distanceScaler + canvasManager.canvasMiddlePoint.y);
        canvasManager.context.scale(distanceScaler, distanceScaler);
        canvasManager.context.strokeStyle = "orange";
        canvasManager.context.lineWidth = 5;
        canvasManager.context.beginPath();
        canvasManager.context.arc(0, 0, cc.collisionRadius, 0, PI*2);
        canvasManager.context.closePath();
        canvasManager.context.stroke();
        canvasManager.context.restore();
      }
      
      // Entity count
      canvasManager.context.save();
      canvasManager.context.translate(        canvasManager.canvasDrawArea.right,
          canvasManager.canvasDrawArea.bottom);
      canvasManager.context.scale(canvasManager.drawScaler, canvasManager.drawScaler);
      int px = (canvasManager.drawScaler * 30).ceil();
      canvasManager.context.font = px.toString() + "px Arial";
      canvasManager.context.fillStyle = "green";
      canvasManager.context.fillText("Entities: $_entityCount", -100, -10);
      canvasManager.context.restore();
    }
  }
    
  void attachWorld(World world) {
  }
  
  void detachWorld() {
  }
  
  void entityActivation(Entity entity) {
    _entityCount++;
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
    if (entity.hasComponent(PathFollowerComponent)) {
      _pathEntities.add(entity);
    }
    if (entity.hasComponent(CollisionComponent) &&
        entity.hasComponent(PositionComponent)) {
      _collisionEntities.add(entity);
    }
  }
  
  void entityDeactivation(Entity entity) {
    _entityCount--;
    if (entity == _centerEntity) _centerEntity = null;
    _velocityEntities.remove(entity);
    _wanderingEntities.remove(entity);
    _pathEntities.remove(entity);
    _collisionEntities.remove(entity);
  }
}