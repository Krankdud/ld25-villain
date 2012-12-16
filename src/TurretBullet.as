package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;

	public class TurretBullet extends Entity
	{
		private var _speed:Point;
		
		public function TurretBullet(x:int, y:int, xspeed:Number, yspeed:Number) 
		{
			super(x, y);
			setHitbox(2, 2, 1, 1);
			
			type = "enemy";
			
			var i:Image = new Image(Resources.IMG_BULLET);
			i.centerOrigin();
			graphic = i;
			
			_speed = new Point(xspeed, yspeed);
		}
		
		override public function update():void
		{
			x += _speed.x;
			y += _speed.y;
			
			if (collideTypes(Global.TYPE_SOLID, x, y))
				FP.world.remove(this);
		}
		
	}

}