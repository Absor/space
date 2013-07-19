part of space;

class WeaponShootingSystem implements System {
  
  bool enabled;
  int priority;
  
  World _world;
  List<Entity> _singleDirectionWeapons;
    
  WeaponShootingSystem() {
    _singleDirectionWeapons = new List<Entity>();
  }
    
  void process(num timeDelta) {
    for (Entity weapon in _singleDirectionWeapons) {
      WeaponTriggerComponent wtc = weapon.getComponent(WeaponTriggerComponent);
      if (wtc.triggered) {
        RotationComponent rc = weapon.getComponent(RotationComponent);
        WeaponAttributesComponent wac = weapon.getComponent(WeaponAttributesComponent);
        Entity bullet = _world.createEntity(idManager.getFreeId());
        attachBulletComponents(bullet,
            (wac.startVelocity*sin(rc.angleInRadians)).toDouble(),
            (wac.startVelocity*cos(rc.angleInRadians)).toDouble());
        _world.activateEntity(bullet.id);
      }
      wtc.triggered = true;
    }
  }
  
  void attachBulletComponents(Entity bullet, double xVel, double yVel) {
    ImageComponent rc = assetManager.getAsset("image_component", "testbullet");
    bullet.addComponent(rc);
    
    PositionComponent pc = new PositionComponent();
    pc.position = new Vector2.zero();
    bullet.addComponent(pc);
    
    RotationComponent rotation = new RotationComponent();
    rotation.angleInDegrees = 0;
    bullet.addComponent(rotation);
    
    AccelerationComponent ac = new AccelerationComponent();
    ac.acceleration = new Vector2(0.0, 0.0);
    ac.maxForce = 0;
    bullet.addComponent(ac);
    
    VelocityComponent vc = new VelocityComponent();
    vc.velocity = new Vector2(xVel, yVel);
    vc.maxVelocity = vc.velocity.length;
    bullet.addComponent(vc);
    
    CollisionComponent cc = new CollisionComponent();
    cc.collisionRadius = 10;
    bullet.addComponent(cc);
  }
    
  void attachWorld(World world) {
    _world = world;
  }
  
  void detachWorld() {
    _world = null;
  }
  
  void entityActivation(Entity entity) {
    if (entity.hasComponent(WeaponTriggerComponent) &&
        entity.hasComponent(SingleDirectionWeaponComponent) &&
        entity.hasComponent(RotationComponent) &&
        entity.hasComponent(WeaponAttributesComponent)) {
      _singleDirectionWeapons.add(entity);
    }
  }
  
  void entityDeactivation(Entity entity) {
    _singleDirectionWeapons.remove(entity);
  }
}