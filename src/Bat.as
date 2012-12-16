package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;

	public class Bat extends Entity
	{
		private const SPEED:Number = 0.7;
		private const DOWN:Boolean = true;
		private const UP:Boolean = false;
		
		private var _spritemap:Spritemap
		private var _direction:Boolean;
		
		public function Bat(x:int, y:int) 
		{
			super(x, y);
			
			setHitbox(6, 6, 3, 3);
			
			_spritemap = new Spritemap(Resources.IMG_BAT, 9, 9);
			_spritemap.centerOrigin();
			_spritemap.add("fly", [0, 1], 0.2);
			_spritemap.play("fly");
			graphic = _spritemap;
			
			type = "enemy";
			layer = 20;
			
			_direction = FP.random < 0.5 ? UP : DOWN;
		}
		
		override public function update():void
		{
			if (_direction == UP)
			{
				if (collideTypes(Global.TYPE_SOLID, x, y - SPEED))
					_direction = DOWN;
				else
					y -= SPEED;
			}
			else
			{
				if (collideTypes(Global.TYPE_SOLID, x, y + SPEED))
					_direction = UP;
				else
					y += SPEED;
			}
			
			// Get squished
			if (collideTypes(Global.TYPE_SOLID, x, y))
			{
				Global.particleManager.emit(x, y, Global.particleManager.TYPE_SQUISH);
				Resources.sfxSquish.play();
				FP.world.remove(this);
			}
			
			if (Global.player.x < x)
				_spritemap.scaleX = -1;
			else
				_spritemap.scaleX = 1;
		}
		
	}

}