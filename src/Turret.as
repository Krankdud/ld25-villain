package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;

	public class Turret extends Entity
	{
		private const RIGHT:int = 0;
		private const DOWN:int = 1;
		private const LEFT:int = 2;
		private const UP:int = 3;
		
		private const TIMER:int = 90;
		private const SHOOT:int = 30;
		
		private var _spritemap:Spritemap;
		private var _direction:int;
		
		private var _frame:int;
		private var _frameDir:int;
		private var _frameOffset:int;
		
		private var _timer:int;
		
		public function Turret(x:int, y:int) 
		{
			super(x, y);
			setHitbox(8, 8);
			
			_spritemap = new Spritemap(Resources.IMG_TURRET, 8, 8);
			graphic = _spritemap;
			
			_frame = 1;
			_frameDir = FP.random < 0.5 ? RIGHT : LEFT;
			
			_timer = TIMER;
		}
		
		override public function added():void
		{
			if (collideTypes("solid", x + 1, y))
				_direction = LEFT;
			else if (collideTypes("solid", x, y - 1))
				_direction = DOWN;
			else if (collideTypes("solid", x, y + 1))
				_direction = UP;
			else
				_direction = RIGHT;
				
			switch (_direction)
			{
				case RIGHT:
					_spritemap.frame = 4;
					_frameOffset = 3;
					break;
				case DOWN:
					_spritemap.frame = 7;
					_frameOffset = 6;
					break;
				case LEFT:
					_spritemap.frame = 10;
					_frameOffset = 9;
					break;
				case UP:
					_spritemap.frame = 1;
					_frameOffset = 0;
					break;
			}
		}
		
		override public function update():void
		{
			if (_timer <= 0)
			{
				if (_frameDir == RIGHT)
				{
					if (_frame + 1 > 2)
					{
						_frame--;
						_frameDir = LEFT;
					}
					else
						_frame++;
				}
				else
				{
					if (_frame - 1 < 0)
					{
						_frame++;
						_frameDir = RIGHT;
					}
					else
						_frame--;
				}
				
				_timer = TIMER;
			}
			else if (_timer == SHOOT)
			{
				if (_direction == RIGHT)
				{
					switch (_frame)
					{
						case 0:
							FP.world.add(new TurretBullet(x + 4, y + 4, 0.7, -0.7));
							break;
						case 1:
							FP.world.add(new TurretBullet(x + 4, y + 4, 1, 0));
							break;
						case 2:
							FP.world.add(new TurretBullet(x + 4, y + 4, 0.7, 0.7));
							break;
					}
				}
				else if (_direction == DOWN)
				{
					switch (_frame)
					{
						case 0:
							FP.world.add(new TurretBullet(x + 4, y + 4, -0.7, 0.7));
							break;
						case 1:
							FP.world.add(new TurretBullet(x + 4, y + 4, 0, 1));
							break;
						case 2:
							FP.world.add(new TurretBullet(x + 4, y + 4, 0.7, 0.7));
							break;
					}
				}
				else if (_direction == LEFT)
				{
					switch (_frame)
					{
						case 0:
							FP.world.add(new TurretBullet(x + 4, y + 4, -0.7, -0.7));
							break;
						case 1:
							FP.world.add(new TurretBullet(x + 4, y + 4, -1, 0));
							break;
						case 2:
							FP.world.add(new TurretBullet(x + 4, y + 4, -0.7, 0.7));
							break;
					}
				}
				else if (_direction == UP)
				{
					switch (_frame)
					{
						case 0:
							FP.world.add(new TurretBullet(x + 4, y + 4, -0.7, -0.7));
							break;
						case 1:
							FP.world.add(new TurretBullet(x + 4, y + 4, 0, -1));
							break;
						case 2:
							FP.world.add(new TurretBullet(x + 4, y + 4, 0.7, -0.7));
							break;
					}
				}
				
				_timer--;
			}
			else
			{
				_timer--;
			}
			
			_spritemap.frame = _frameOffset + _frame;
		}
		
	}

}