package  
{
	import net.flashpunk.graphics.Image;
	
	public class Bars extends Triggerable
	{
		private var _image:Image;
		
		public function Bars(x:int, y:int, h:int) 
		{
			super(x, y);
			
			setHitbox(16, h);
			
			_image = new Image(Resources.IMG_BARS);
			_image.scaleY = h;
			graphic = _image;
			
			type = "solid";
		}
		
		override public function update():void
		{
			if (triggered)
			{
				if (_image.scaleY > 0)
				{
					_image.scaleY--;
					setHitbox(16, _image.scaleY);
				}
			}
			else
			{
				if (!collideTypes(Global.TYPE_SOLID, x, y + 1) && !collide("player", x, y + 1))
				{
					_image.scaleY++;
					setHitbox(16, _image.scaleY);
				}
			}
		}
		
	}

}