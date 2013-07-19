part of space;

class EntityBuilder {
  
  Entity _entity;
  
  EntityBuilder(this._entity) {}
  
  EntityBuilder addImageComponent(String icName) {
    _entity.addComponent(assetManager.getAsset("image_component", icName));
    return this;
  }
  
  EntityBuilder addPositionComponent(Vector2 position) {
    PositionComponent pc = new PositionComponent();
    pc.position = position;
    _entity.addComponent(pc);
    return this;
  }
  
  EntityBuilder addAccelerationComponent(Vector2 acceleration, num maxForce) {
    AccelerationComponent ac = new AccelerationComponent();
    ac.acceleration = acceleration;
    ac.maxForce = maxForce;
    _entity.addComponent(ac);
    return this;
  }
  
  EntityBuilder addVelocityComponent(Vector2 velocity, num maxVelocity) {
    VelocityComponent vc = new VelocityComponent();
    vc.velocity = velocity;
    vc.maxVelocity = maxVelocity;
    _entity.addComponent(vc);
    return this;
  }
  
  EntityBuilder addCameraCenteringComponent() {
    _entity.addComponent(new CameraCenteringComponent());
    return this;
  }
  
  EntityBuilder addRotationComponent(num angleInDegrees) {
    RotationComponent rc = new RotationComponent();
    rc.angleInDegrees = angleInDegrees;
    _entity.addComponent(rc);
    return this;
  }
  
  EntityBuilder addCollisionComponent(num collisionRadius) {
    CollisionComponent cc = new CollisionComponent();
    cc.collisionRadius = collisionRadius;
    _entity.addComponent(cc);
    return this;
  }
  
  EntityBuilder addAttachComponent(int targetId, Vector2 offset) {
    AttachComponent ac = new AttachComponent();
    ac.targetId = targetId;
    ac.offset = offset;
    _entity.addComponent(ac);
    return this;
  }
  
  EntityBuilder addTargetComponent() {
    _entity.addComponent(new TargetComponent());
    return this;
  }
  
  EntityBuilder addImageScalingComponent(num imageScaler) {
    ImageScalingComponent isc = new ImageScalingComponent();
    isc.imageScaler = imageScaler;
    _entity.addComponent(isc);
    return this;
  }
  
  EntityBuilder addWeaponTriggerComponent(bool triggered) {
    WeaponTriggerComponent wtc = new WeaponTriggerComponent();
    wtc.triggered = triggered;
    _entity.addComponent(wtc);
    return this;
  }
  
  EntityBuilder addRepeatingWeaponComponent(num timeBetweenShots, num timeSinceLast) {
    RepeatingWeaponComponent rwc = new RepeatingWeaponComponent();
    rwc.timeBetweenShots = timeBetweenShots;
    rwc.timeSinceLast = timeSinceLast;
    _entity.addComponent(rwc);
    return this;
  }
  
  EntityBuilder addWeaponAttributesComponent(num startVelocity) {
    WeaponAttributesComponent wac = new WeaponAttributesComponent();
    wac.startVelocity = startVelocity;
    _entity.addComponent(wac);
    return this;
  }
  
  EntityBuilder addSingleDirectionWeaponComponent() {
    _entity.addComponent(new SingleDirectionWeaponComponent());
    return this;
  }
  
  EntityBuilder addPlayerWeaponComponent() {
    _entity.addComponent(new PlayerWeaponComponent());
    return this;
  }
  
  EntityBuilder addPredictingWeaponComponent() {
    _entity.addComponent(new PredictingWeaponComponent());
    return this;
  }
  
  Entity build() {
    return _entity;
  }
}