part of space;

class TargetPredictingSystem implements System {
  
  bool enabled;
  int priority;
  
  List<Entity> _playerWeapons;
  List<Entity> _enemyWeapons;
  Entity _playerTarget;
  Entity _enemyTarget;
    
  TargetPredictingSystem() {
    _playerWeapons = new List<Entity>();
    _enemyWeapons = new List<Entity>();
  }
    
  void process(num timeDelta) {
    if (_enemyTarget != null) {
      
    }
    
    if (_playerTarget != null) {
      PositionComponent ppc = _playerTarget.getComponent(PositionComponent);
      for (Entity entity in _playerWeapons) {
        RotationComponent rc = entity.getComponent(RotationComponent);
        PositionComponent epc = entity.getComponent(PositionComponent);
        Vector2 relative = ppc.position - epc.position;
        num angle = atan2(relative.x, -relative.y);
        rc.angleInRadians = angle;
      }
    }
  }
  
//// Find the relative position and velocities
//Vector3 delta = target.position - gun.position;
//Vector3 vr = target.velocity - gun.velocity;
//
//// Calculate the time a bullet will collide
//// if it's possible to hit the target.
//float t = AimAhead(delta, vr, muzzleV);
//
//// If the time is negative, then we didn't get a solution.
//if(t > 0f){
//  // Aim at the point where the target will be at the time
//  // of the collision.
//  Vector3 aimPoint = target.position + t*vr;
//
//  // fire at aimPoint!!!
//}
  
//// Calculate the time when we can hit a target with a bullet
//// Return a negative time if there is no solution
//protected float AimAhead(Vector3 delta, Vector3 vr, float muzzleV){
//  // Quadratic equation coefficients a*t^2 + b*t + c = 0
//  float a = Vector3.Dot(vr, vr) - muzzleV*muzzleV;
//  float b = 2f*Vector3.Dot(vr, delta);
//  float c = Vector3.Dot(delta, delta);
//
//  float det = b*b - 4f*a*c;
//
//  // If the determinant is negative, then there is no solution
//  if(det > 0f){
//    return 2f*c/(Mathf.Sqrt(det) - b);
//  } else {
//    return -1f;
//  }
//}
    
  void attachWorld(World world) {
  }
  
  void detachWorld() {
  }
  
  void entityActivation(Entity entity) {
    if (entity.hasComponent(PositionComponent) &&
        entity.hasComponent(PlayerComponent)) {
      _enemyTarget = entity;
    }
    if (entity.hasComponent(PositionComponent) &&
        entity.hasComponent(TargetComponent)) {
      _playerTarget = entity;
    }
    if (entity.hasComponent(PositionComponent) &&
        entity.hasComponent(RotationComponent) && 
        entity.hasComponent(PredictingWeaponComponent) &&
        entity.hasComponent(PlayerWeaponComponent)) {
      _playerWeapons.add(entity);
    }
    if (entity.hasComponent(PositionComponent) &&
        entity.hasComponent(RotationComponent) && 
        entity.hasComponent(PredictingWeaponComponent) &&
        entity.hasComponent(EnemyWeaponComponent)) {
      _enemyWeapons.add(entity);
    }
  }
  
  void entityDeactivation(Entity entity) {
    if (_enemyTarget == entity) _enemyTarget = null;
    if (_playerTarget == entity) _playerTarget = null;
    _playerWeapons.remove(entity);
    _enemyWeapons.remove(entity);
  }
}