package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;

	public class Camera 
	{
		public var follow:Entity;
		
		public function Camera() 
		{
			follow = null;
		}
		
		public function update():void
		{
			if (follow)
			{
				FP.camera.x = FP.clamp(Math.round(follow.centerX - FP.halfWidth), 0, Global.levelWidth - FP.width);
				FP.camera.y = FP.clamp(Math.round(follow.centerY - FP.halfHeight), 0, Global.levelHeight - FP.height);
			}
		}
		
		
	}

}