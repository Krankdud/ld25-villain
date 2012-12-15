package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class Player extends Entity
	{
		private const ACCEL:Number = 0.3;
		private const FRICTION:Number = 0.2;
		private const MAX_SPEED:Number = 3;
		
		private var _speed:Point;
		
		private var _spritemap:Spritemap;
		private var _abductefx:Spritemap;
		
		private var _holding:Holdable;
		
		public function Player(x:int, y:int) 
		{
			super(x, y);
			setHitbox(8, 8, 4, 4);
			
			type = "player";
			
			_spritemap = new Spritemap(Resources.IMG_UFO, 16, 11);
			_spritemap.centerOrigin();
			_spritemap.y = -1;
			_spritemap.add("fly", [0, 1, 2, 1], 0.15);
			_spritemap.add("abduct", [1]);
			_spritemap.play("fly");
			
			_abductefx = new Spritemap(Resources.IMG_EFX_ABDUCT, 16, 16);
			_abductefx.centerOrigin();
			_abductefx.originY = 0;
			_abductefx.y = 4;
			_abductefx.add("a", [0, 1, 2, 3, 2, 1], 0.2);
			_abductefx.play("a");
			_abductefx.visible = false;
			
			graphic = new Graphiclist(_abductefx, _spritemap);
			
			_speed = new Point();
			_holding = null;
		}
		
		override public function update():void
		{
			if (Input.check(Key.RIGHT))
			{
				_speed.x += ACCEL;
			}
			else if (Input.check(Key.LEFT))
			{
				_speed.x -= ACCEL;
			}
			if (Input.check(Key.DOWN))
			{
				_speed.y += ACCEL;
			}
			else if (Input.check(Key.UP))
			{
				_speed.y -= ACCEL;
			}
			
			if (!Input.check(Key.LEFT) && !Input.check(Key.RIGHT))
			{
				if (_speed.x > 0.2)
					_speed.x -= FRICTION;
				else if (_speed.x < -0.2)
					_speed.x += FRICTION;
				else
					_speed.x = 0;
			}
			
			if (!Input.check(Key.DOWN) && !Input.check(Key.UP))
			{
				if (_speed.y > 0.2)
					_speed.y -= FRICTION;
				else if (_speed.y < -0.2)
					_speed.y += FRICTION;
				else
					_speed.y = 0;
			}
			
			if (Input.check(Key.X))
			{
				_spritemap.play("abduct");
				_abductefx.visible = true;
				
				// Holdables
				if (!_holding)
				{
					var e:Entity = collideTypes(Global.TYPE_HOLDABLE, x, y + 16);
					if (e && !e.collideTypes(Global.TYPE_SOLID, x, y + 14))
					{
						_holding = e as Holdable;
						_holding.held = true;
					}
				}
				
				// Abductables
				if (!_holding)
				{
					e = collideTypes(Global.TYPE_ABDUCTABLE, x, y + 16);
					if (e)
						(e as Abductable).abduct = true;
				}
			}
			else
			{
				_spritemap.play("fly");
				_abductefx.visible = false;
				
				if (_holding)
				{
					_holding.held = false;
					_holding = null;
				}
			}
			
			_speed.x = FP.clamp(_speed.x, -MAX_SPEED, MAX_SPEED);
			_speed.y = FP.clamp(_speed.y, -MAX_SPEED, MAX_SPEED);
			
			if (_holding)
			{
				if (_holding.collideTypes(Global.TYPE_SOLID, _holding.x + _speed.x, _holding.y + _speed.y))
				{
					_holding.held = false;
					_holding = null;
				}
			}
			
			if (collide("enemy", x + _speed.x, y + _speed.y))
			{
				Global.particleManager.emit(x, y, Global.particleManager.TYPE_PLAYER);
				FP.world.remove(this);
			}
			
			if (_speed.x != 0)
			{	
				if (collideTypes(Global.TYPE_SOLID, x + _speed.x, y))
				{
					var xs:int = FP.sign(_speed.x);
					for (var i:int = 0; i < Math.abs(_speed.x); i++)
					{
						if (collideTypes(Global.TYPE_SOLID, x + xs, y))
						{
							_speed.x = 0;
							break;
						}
						
						x += xs;
					}
					
					_speed.x = 0;
				}
				else
					x += _speed.x;
			}
			
			if (_speed.y != 0)
			{
				if (collideTypes(Global.TYPE_SOLID, x, y + _speed.y))
				{
					var ys:int = FP.sign(_speed.y);
					for (i = 0; i < Math.abs(_speed.y); i++)
					{
						if (collideTypes(Global.TYPE_SOLID, x, y + ys))
						{
							_speed.y = 0;
							break;
						}
						
						y += ys;
					}
					
					_speed.y = 0;
				}
				else
					y += _speed.y;
			}
			
			x = FP.clamp(x, 0, Global.levelWidth);
			y = FP.clamp(y, 0, Global.levelHeight);
			
			if (_holding)
			{
				_holding.x = x;
				_holding.y = y + 14;
			}
			
			super.update();
		}
		
	}

}