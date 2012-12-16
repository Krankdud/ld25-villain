package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class VolumeControl extends Entity
	{
		private const TIMER:int = 180;
		private var _timer:int;
		private var _text:Text;
		
		public function VolumeControl() 
		{
			super();
			
			var o:Object = new Object();
			o.width = FP.width;
			o.align = "right";
			o.color = 0xaec741;
			o.size = 16;
			_text = new Text("Volume: 100", 0, 2, o);
			_text.visible = false;
			
			graphic = _text;
		}
		
		override public function update():void
		{
			if (Input.pressed(Key.DIGIT_0))
			{
				FP.volume = (FP.volume + 0.1 > 1 ? 1 : FP.volume + 0.1);
				_timer = TIMER;
				Resources.sfxPickup.play();
			}
			else if (Input.pressed(Key.DIGIT_9))
			{
				FP.volume = (FP.volume - 0.1 < 0 ? 0 : FP.volume - 0.1);
				_timer = TIMER;
				Resources.sfxPickup.play();
			}
			
			if (_timer > 0)
			{
				_text.x = FP.camera.x;
				_text.y = FP.camera.y + 2;
				_text.visible = true;
				_text.text = "Volume: " + Math.round(FP.volume * 100).toString();
				_timer--;
			}
			else
				_text.visible = false;
		}
		
	}

}