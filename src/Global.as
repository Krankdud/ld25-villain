package  
{

	public class Global 
	{
		static public const TYPE_SOLID:Array = new Array("solid", "solidHoldable");
		static public const TYPE_HOLDABLE:Array = new Array("holdable", "solidHoldable");
		static public const TYPE_ABDUCTABLE:Array = new Array("abductable");
		
		static public const GOAL_ABDUCT:int = 0;
		static public const GOAL_SQUISH:int = 1;
		static public const GOAL_GOATS:int = 2;
		
		static public var levelWidth:int;
		static public var levelHeight:int;
		
		static public var player:Player;
		static public var playerDead:Boolean = false;
		static public var levelFinished:Boolean = false;
		
		static public var currentLevel:String;
		static public var nextLevel:String;
		
		static public var goalType:int;
		static public var goalAmount:int;
		static public var goalCurrent:int;
		
		static public var particleManager:ParticleManager;
		
		static public var paused:Boolean = false;
		
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