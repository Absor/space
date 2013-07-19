part of space;

class UISystem implements System {
  
  bool enabled;
  int priority;
  
  World _world;
  List<Entity> _enemyEntities;
  Entity _target;
  Entity _centerEntity;
      
  UISystem() {
    _enemyEntities = new List<Entity>();
  }
    
  void process(num timeDelta) {
    if (_centerEntity == null) return;
    if (inputManager.isMouseDown) {
      // first ui element check, then if not, this
      inputManager.isMouseDown = false;
      _findTarget(inputManager.canvasMousePosition);
    }
    
    // Bottom half-circle with HP info
    canvasManager.context.save();
    canvasManager.context.translate(canvasManager.canvasMiddlePoint.x,
        canvasManager.canvasDrawArea.bottom);
    canvasManager.context.scale(canvasManager.drawScaler, canvasManager.drawScaler);
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
  
  void _findTarget(Vector2 canvasPosition) {
    Vector2 worldPosition = canvasPosition - canvasManager.canvasMiddlePoint;
    num positionScaler = canvasManager.drawScaler * settings.pixelsPerMeter;
    worldPosition.scale(1/positionScaler);
    PositionComponent worldMiddle = _centerEntity.getComponent(PositionComponent);
    worldPosition.add(worldMiddle.position);
    
    int id;
    num minDistance = 1e10;
    for (Entity enemy in _enemyEntities) {
      PositionComponent pc = enemy.getComponent(PositionComponent);
      num distanceFromPoint = (pc.position - worldPosition).length2;
      if (distanceFromPoint < minDistance) {
        minDistance = distanceFromPoint;
        id = enemy.id;
      }
    }
    if (id != null) _setTarget(id);
  }
  
  void _setTarget(int id) {
    if (_target == null) {
      _target = _world.createEntity(idManager.getFreeId());
      attachTargetComponents(_target, id);
      _world.activateEntity(_target.id);
    } else {
      AttachComponent ac = _target.getComponent(AttachComponent);
      ac.targetId = id;
    }
  }
  
  void attachTargetComponents(Entity target, int attachId) {
    ImageComponent ic = assetManager.getAsset("image_component", "target");
    target.addComponent(ic);
    
    PositionComponent pc = new PositionComponent();
    pc.position = new Vector2.zero();
    target.addComponent(pc);
    
    AttachComponent ac = new AttachComponent();
    ac.targetId = attachId;
    ac.offset = new Vector2.zero();
    target.addComponent(ac);
    
    target.addComponent(new TargetComponent());
  }
    
  void attachWorld(World world) {
    _world = world;
  }
  
  void detachWorld() {
    _world = null;
  }
  
  void entityActivation(Entity entity) {
    if (entity.hasComponent(CameraCenteringComponent) &&
        entity.hasComponent(PositionComponent)) {
      _centerEntity = entity;
    }
    if (entity.hasComponent(PositionComponent) &&
        entity.hasComponent(EnemyComponent)) {
      _enemyEntities.add(entity);
    }
  }
  
  void entityDeactivation(Entity entity) {
    if (entity == _centerEntity) _centerEntity = null;
    _enemyEntities.remove(entity);
    if (entity == _target) _target = null;
  }
}