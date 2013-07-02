part of space;

class ImageRenderingSystem implements System {
  
  bool enabled;
  int priority;
    
  List<Entity> _renderables;
  
  Entity _centerEntity;
    
  ImageRenderingSystem() {
    _renderables = new List<Entity>();
  }
  
  void process(num timeDelta) {
    if (_centerEntity == null) return;
    
    PositionComponent cpc = _centerEntity.getComponent(PositionComponent);
    Vector2 centerPosition = cpc.position;
    
    for (Entity entity in _renderables) {
      ImageComponent renderable = entity.getComponent(ImageComponent);
      PositionComponent pc = entity.getComponent(PositionComponent);
      Vector2 position = pc.position;
      canvasManager.context.save();
      num distanceScaler = canvasManager.drawScaler * settings.pixelsPerMeter;
      canvasManager.context.translate(
          (position.x - centerPosition.x) * distanceScaler + canvasManager.canvasMiddlePoint.x,
          (position.y - centerPosition.y) * distanceScaler + canvasManager.canvasMiddlePoint.y);
      if (entity.hasComponent(RotationComponent)) {
        RotationComponent rotation = entity.getComponent(RotationComponent);
        canvasManager.context.rotate(rotation.angleInRadians);
      }
      if (entity.hasComponent(AlphaComponent)) {
        AlphaComponent ac = entity.getComponent(AlphaComponent);
        canvasManager.context.globalAlpha = ac.alpha;
      }
      num imageScaler = renderable.imageScaler * distanceScaler;
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
    if (entity.hasComponent(ImageComponent) &&
        entity.hasComponent(PositionComponent)) {
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