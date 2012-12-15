package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;

	public class Abductable extends Entity
	{
		public var abduct:Boolean = false;
		
		public function Abductable(x:int = 0, y:int = 0, graphic:Graphic = null, mask:Mask = null) 
		{
			super(x, y, graphic, mask);
		}
		
		override public function update():void
		{
			if (abduct)
			{
				moveTowards(Global.player.x, Global.player.y, 4);
				
				if (collide("player", x, y))
				{
					FP.world.remove(this);
				}
			}
		}
		
	}

}