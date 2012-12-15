package  
{

	public class Global 
	{
		static public const TYPE_SOLIDS:Array = new Array("solid", "solidHoldable");
		static public const TYPE_HOLDABLE:Array = new Array("holdable", "solidHoldable");
		static public const TYPE_ABDUCTABLE:Array = new Array("abductable");
		
		static public var levelWidth:int;
		static public var levelHeight:int;
		
		static public var player:Player;
		
		static private var _camera:Camera;
		
		public function Global() 
		{
			
		}
		
		static public function get camera():Camera
		{
			if (!_camera)
				_camera = new Camera();
			return _camera;
		}
		
	}

}