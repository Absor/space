part of space;

class PathFollowerSystem implements System {
  
  bool enabled;
  int priority;
  
  List<Entity> _pathFollowingEntities;
    
  PathFollowerSystem() {
    _pathFollowingEntities = new List<Entity>();
  }
    
  void process(num timeDelta) {
    for (Entity entity in _pathFollowingEntities) {
      PathFollowerComponent pfc = entity.getComponent(PathFollowerComponent);
      FollowerComponent fc = entity.getComponent(FollowerComponent);
      AccelerationComponent ac = entity.getComponent(AccelerationComponent);
      VelocityComponent vc = entity.getComponent(VelocityComponent);
      PositionComponent pc = entity.getComponent(PositionComponent);
      
      Vector2 target;
      num minDistance = 1000000;
      Vector2 predictLoc = pc.position + vc.velocity;
      
      for (int i = 0; i < pfc.pathPoints.length; i++) {
        Vector2 a = pfc.pathPoints[i];
        Vector2 b;
        if (i == pfc.pathPoints.length - 1) {
          b = pfc.pathPoints[0];
        } else {
          b = pfc.pathPoints[i+1];
        }
        Vector2 normalPoint = _getNormalPoint(predictLoc, a, b);
        if (normalPoint.x < a.x || normalPoint.x > b.x) {
          normalPoint = b.clone();
        }
        
        num distance = (normalPoint - predictLoc).length;
        
        if (distance < minDistance) {
          minDistance = distance;
          
          Vector2 dir = (b - a).normalize().scale(vc.maxVelocity.toDouble());
          fc.targetPosition = normalPoint.add(dir);
        }
      }
    }
  }
  
  Vector2 _getNormalPoint(Vector2 p, Vector2 a, Vector2 b) {
    // Vector2 that points from a to p
    Vector2 ap = p - a;
    // Vector2 that points from a to b
    Vector2 ab = b - a;
    // Using the dot product for scalar projection
    ab.normalize();
    ab.scale(ap.dot(ab));
    // Finding the normal point along the line segment
    return a + ab;
  }
    
  void attachWorld(World world) {
  }
  
  void detachWorld() {
  }
  
  void entityActivation(Entity entity) {
    if (entity.hasComponent(PathFollowerComponent) &&
        entity.hasComponent(FollowerComponent) &&
        entity.hasComponent(AccelerationComponent) &&
        entity.hasComponent(VelocityComponent) &&
        entity.hasComponent(PositionComponent)) {
      _pathFollowingEntities.add(entity);
    }
  }
  
  void entityDeactivation(Entity entity) {
    _pathFollowingEntities.remove(entity);
  }
}