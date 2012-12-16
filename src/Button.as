package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;

	public class Button extends Entity
	{
		private var _target:Triggerable;
		private var _spritemap:Spritemap;
		
		private var _sound:Boolean = false;
		
		public function Button(x:int, y:int) 
		{
			super(x, y);
			
			_spritemap = new Spritemap(Resources.IMG_BUTTON, 16, 16);
			_spritemap.add("off", [0]);
			_spritemap.add("on", [1]);
			_spritemap.play("off");
			graphic = _spritemap;
			
			setHitbox(16, 3, 0, -13);
			
			type = "solid";
			
			layer = 60;
		}
		
		override public function update():void 
		{
			if (_target)
			{
				if (collideTypes(Global.TYPE_SOLID, x, y - 1))
				{
					_target.triggered = true;
					_spritemap.play("on");
					
					if (_sound == false)
					{
						Resources.sfxButton.play();
						_sound = true;
					}
				}
				else
				{
					_target.triggered = false;
					_spritemap.play("off");
					
					if (_sound == true)
					{
						Resources.sfxButton.play();
						_sound = false;
					}
				}
			}
		}
		
		public function setTarget(t:Entity):void
		{
			if (t is Triggerable)
				_target = t as Triggerable;
		}
		
	}

}