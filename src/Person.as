package  
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;

	public class Person extends Abductable
	{
		private const TIME_MIN:int = 30;
		private const TIME_MAX:int = 120;
		private const SPEED:int = 2;
		private const FRICTION:Number = 0.4;
		
		private var _image:Image;
		private var _timer:int;
		private var _speed:Number;
		
		private var _squished:Boolean;
		
		public function Person(x:int, y:int) 
		{
			super(x + 8, y + 4);
			
			type = "abductable";
			
			setHitbox(4, 4, 2, 2);
			
			_image = new Image(Resources.IMG_PERSON);
			_image.centerOrigin();
			_image.scaleX = FP.random < 0.5 ? 1 : -1;
			
			_timer = TIME_MIN + FP.random * TIME_MAX;
			
			_speed = 0;
			_squished = false;
			
			graphic = _image;
			
			layer = 40;
		}
		
		override public function removed():void
		{
			if (Global.goalType == Global.GOAL_ABDUCT && !_squished)
				Global.goalCurrent++;
			else if (Global.goalType == Global.GOAL_SQUISH && _squished)
				Global.goalCurrent++;
			
			if (_squished)
				Global.particleManager.emit(x, y, Global.particleManager.TYPE_SQUISH);
		}
		
		override public function update():void
		{
			if (!abduct)
			{
				if (_timer <= 0)
				{
					if (FP.random < 0.3)
					{
						_image.scaleX = -_image.scaleX;
					}
					else
					{
						_speed = SPEED * _image.scaleX;
						_image.y = -1;
					}
					
					_timer = TIME_MIN + FP.random * TIME_MAX;
				}
				else
					_timer--;
					
				if (_speed != 0)
				{
					if (collideTypes(Global.TYPE_SOLID, x + _speed, y) || !collideTypes(Global.TYPE_SOLID, x + _speed, y + 4))
					{
						_speed = 0;
					}
					else
					{
						x += _speed;
						x = Math.round(x);
						
						if (_speed > 0.3)
							_speed -= FRICTION;
						else if (_speed < -0.3)
							_speed += FRICTION;
						else
							_speed = 0;
					}
				}
				else
					_image.y = 0;
					
				// Get squished
				if (collideTypes(Global.TYPE_SOLID, x, y))
				{
					_squished = true;
					FP.world.remove(this);
				}
			}
			
			super.update();
		}
		
	}

}