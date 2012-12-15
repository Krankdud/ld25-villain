package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;

	public class Box extends Holdable
	{
		private const GRAVITY:Number = 0.8;
		private const MAX_SPEED:Number = 4;
		private var _speed:Number = 0;
		
		public function Box(x:int, y:int) 
		{
			super(x + 4, y + 2, new Image(Resources.IMG_BOX));
			setHitbox(12, 12, 6, 6);
			(graphic as Image).centerOrigin();
			
			type = "solidHoldable";
			
			layer = 50;
		}
		
		override public function update():void
		{
			if (!collideTypes(Global.TYPE_SOLIDS, x, y + _speed + 1) && !held)
				_speed += GRAVITY;
				
			if (_speed != 0)
			{
				
				if (collideTypes(Global.TYPE_SOLIDS, x, y + _speed))
				{
					var ys:int = FP.sign(_speed);
					for (var i:int = 0; i < Math.abs(_speed); i++)
					{
						if (collideTypes(Global.TYPE_SOLIDS, x, y + ys))
						{
							_speed = 0;
							break;
						}
						
						y += ys;
					}
					
					_speed = 0;
				}
				else
					y += _speed;
			}
		}
		
	}

}