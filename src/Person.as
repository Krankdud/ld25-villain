package  
{
	import net.flashpunk.graphics.Image;

	public class Person extends Abductable
	{
		private var _image:Image;
		
		public function Person(x:int, y:int) 
		{
			super(x + 8, y + 4);
			
			type = "abductable";
			
			setHitbox(2, 4, 1, 2);
			
			_image = new Image(Resources.IMG_PERSON);
			_image.centerOrigin();
			
			graphic = _image;
			
			layer = 40;
		}
		
	}

}