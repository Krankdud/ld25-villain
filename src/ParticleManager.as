package  
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	
	public class ParticleManager extends Entity
	{
		public const TYPE_PLAYER:int = 0;
		public const TYPE_SQUISH:int = 1;
		
		private var _emitter:Emitter;
		
		public function ParticleManager() 
		{
			super();
			
			_emitter = new Emitter(new BitmapData(1, 1, false, 0xFFFFFF));
			
			_emitter.newType("off");
			_emitter.newType("dark");
			_emitter.newType("light");
			
			_emitter.setAlpha("off", 1, 1);
			_emitter.setColor("off", 0x204530, 0x204530);
			_emitter.setGravity("off", 1, 4);
			_emitter.setMotion("off", 0, 10, 5, 360, 20, 5);
			
			_emitter.setAlpha("dark", 1, 1);
			_emitter.setColor("dark", 0x517d38, 0x517d38);
			_emitter.setGravity("dark", 1, 4);
			_emitter.setMotion("dark", 0, 10, 5, 360, 20, 5);
			
			_emitter.setAlpha("light", 1, 1);
			_emitter.setColor("light", 0xaec741, 0xaec741);
			_emitter.setGravity("light", 1, 4);
			_emitter.setMotion("light", 0, 10, 5, 360, 20, 5);
			
			graphic = _emitter;
		}
		
		public function emit(x:int, y:int, type:int):void
		{
			if (type == TYPE_PLAYER)
			{
				for (var i:int = 0; i < 1000; i++)
				{
					if (FP.random < 0.33)
						_emitter.emit("off", x, y);
					else if (FP.random < 0.66)
						_emitter.emit("dark", x, y);
					else
						_emitter.emit("light", x, y);
				}
			}
			else if (type == TYPE_SQUISH)
			{
				for (i = 0; i < 30; i++)
				{
					if (FP.random < 0.33)
						_emitter.emit("off", x, y);
					else if (FP.random < 0.66)
						_emitter.emit("dark", x, y);
					else
						_emitter.emit("light", x, y);
				}
			}
		}
		
	}

}