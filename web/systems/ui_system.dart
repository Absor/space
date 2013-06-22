part of space;

class UISystem implements System {
  
  bool enabled;
  int priority;
  
  List<Entity> _collidingEntities;
    
  UISystem() {
    _collidingEntities = new List<Entity>();
  }
    
  void process(num timeDelta) {
    
    // Bottom half-circle with HP info
    canvasManager.context.save();
    num scaler = canvasManager.canvasDrawArea.height / settings.screenHeight;
    canvasManager.context.translate(canvasManager.canvasMiddlePoint.x,
        canvasManager.canvasDrawArea.bottom);
    canvasManager.context.scale(scaler, scaler);
    canvasManager.context.globalAlpha = 0.4;
    // Shield
    canvasManager.context.fillStyle = "blue";
    canvasManager.context.beginPath();
    canvasManager.context.arc(0, 0, 90, -PI, 0);
    canvasManager.context.arc(0, 0, 60, 0, -PI, true);
    canvasManager.context.closePath();
    canvasManager.context.fill();
    // Hull
    canvasManager.context.fillStyle = "green";
    canvasManager.context.lineWidth = 5;
    canvasManager.context.beginPath();
    canvasManager.context.arc(0, 0, 55, -PI, 0);
    canvasManager.context.arc(0, 0, 25, 0, -PI, true);
    canvasManager.context.closePath();
    canvasManager.context.fill();
    canvasManager.context.restore();
  }
    
  void attachWorld(World world) {
  }
  
  void detachWorld() {
  }
  
  void entityActivation(Entity entity) {
    if (entity.hasComponent(CollisionComponent) &&
        entity.hasComponent(PositionComponent)) {
      _collidingEntities.add(entity);
    }
  }
  
  void entityDeactivation(Entity entity) {
    _collidingEntities.remove(entity);
  }
}