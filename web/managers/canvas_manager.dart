part of space;

class CanvasManager {
  
  CanvasElement _canvas;
  CanvasRenderingContext2D _context;
  Rect _canvasDrawArea;
  num _drawScaler;
  Point _canvasMiddlePoint;
  
  CanvasManager(this._canvas) {
    _context = _canvas.context2D;
    _resize();
    window.onResize.listen((e) => _resize());
  }
  
  CanvasElement get canvas => _canvas;
  CanvasRenderingContext2D get context => _context;
  num get drawScaler => _drawScaler;
  Point get canvasMiddlePoint => _canvasMiddlePoint;
  
  void _resize() {
    _canvas.height = window.innerHeight;
    _canvas.width = window.innerWidth;
    _calculateDrawArea();
  }
  
  void _calculateDrawArea() {
    num canvasRatio = _canvas.width / _canvas.height;
    num screenRatio = settings.getScreenRatio();
    num width;
    num height;
    if (canvasRatio > screenRatio) {
        width = screenRatio * _canvas.height;
        height = _canvas.height;
    } else {
        width = _canvas.width;
        height = _canvas.width / screenRatio;
    }
    num left = (_canvas.width - width) / 2;
    num top = (_canvas.height - height) / 2;
    
    _canvasDrawArea = new Rect(left, top, width, height);
    _drawScaler = width / settings.screenWidth;
    _canvasMiddlePoint = new Point(_canvas.width / 2, _canvas.height / 2);
  }
  
  void clearCanvas() {
    _context.clearRect(0, 0, _canvas.width, _canvas.height);
  }
}