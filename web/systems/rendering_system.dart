part of space;

class RenderingSystem implements System {
  
  bool enabled;
  int priority;
    
  List<Entity> _renderables;
  
  Entity _centerEntity;
    
  RenderingSystem() {
    _renderables = new List<Entity>();
  }
  
  void process(num timeDelta) {
    if (_centerEntity == null) return;
    
    PositionComponent cpc = _centerEntity.getComponent(PositionComponent);
    Vector2 centerPosition = cpc.position;
    
    for (Entity entity in _renderables) {
      RenderComponent renderable = entity.getComponent(RenderComponent);
      PositionComponent pc = entity.getComponent(PositionComponent);
      Vector2 position = pc.position;
      RotationComponent rotation = entity.getComponent(RotationComponent);
      canvasManager.context.save();
      num positionScaler = canvasManager.drawScaler * settings.pixelsPerMeter;
      canvasManager.context.translate(
          (position.x - centerPosition.x) * positionScaler + canvasManager.canvasMiddlePoint.x,
          (position.y - centerPosition.y) * positionScaler + canvasManager.canvasMiddlePoint.y);
      canvasManager.context.rotate(rotation.angleInRadians);
      num imageScaler = renderable.imageScaler * positionScaler;
      canvasManager.context.scale(imageScaler, imageScaler);
      canvasManager.context.drawImageScaledFromSource(renderable.source,
          renderable.sourceX, renderable.sourceY,
          renderable.sourceWidth, renderable.sourceHeight,
          renderable.xOffset, renderable.yOffset,
          renderable.sourceWidth, renderable.sourceHeight);
      canvasManager.context.restore();
    }
  }
    
  void attachWorld(World world) {
  }
  
  void detachWorld() {
  }
  
  void entityActivation(Entity entity) {
    if (entity.hasComponent(RenderComponent) &&
        entity.hasComponent(PositionComponent) &&
        entity.hasComponent(RotationComponent)) {
      _renderables.add(entity);
    }
    if (entity.hasComponent(CameraCenteringComponent) &&
        entity.hasComponent(PositionComponent)) {
      _centerEntity = entity;
    }
  }
  
  void entityDeactivation(Entity entity) {
    _renderables.remove(entity);
    if (entity == _centerEntity) _centerEntity = null;
  }
}