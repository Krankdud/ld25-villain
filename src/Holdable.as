package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;

	public class Holdable extends Entity
	{
		public var held:Boolean = false;
		
		public function Holdable(x:int = 0, y:int = 0, graphic:Graphic = null, mask:Mask = null) 
		{
			super(x, y, graphic, mask);
		}
		
	}

}