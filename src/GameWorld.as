package  
{
	import flash.utils.Dictionary;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.World;

	public class GameWorld extends World
	{
		
		public function GameWorld() 
		{
			super();
			
			FP.screen.color = 0xd7eb86;
			
			loadLevel("testlevel");
		}
		
		override public function update():void
		{
			Global.camera.update();
			
			super.update();
		}
		
		public function loadLevel(level:String):void
		{
			var xml:XML = new XML(new (Resources.getLevelFromString(level)));
			
			Global.levelWidth = xml.@width;
			Global.levelHeight = xml.@height;
			
			var grid:Grid = new Grid(xml.@width, xml.@height, 16, 16);
			grid.usePositions = true;
			var tilemap:Tilemap = new Tilemap(Resources.IMG_TILESET, xml.@width, xml.@height, 16, 16);
			
			for each (var o:XML in xml.mask.rect)
			{
				grid.setRect(o.@x, o.@y, o.@w, o.@h);
			}
			
			for each (o in xml.tileset.tile)
			{
				tilemap.setTile(o.@x, o.@y, o.@id);
			}
			
			addMask(grid, "solid");
			addGraphic(tilemap, 1000);
			
			if (xml.entities.elements("player").length() > 0)
			{
				Global.player = new Player(xml.entities.player.@x, xml.entities.player.@y);
				Global.camera.follow = Global.player;
				add(Global.player);
			}
			
			if (xml.entities.elements("box").length() > 0)
			{
				for each (o in xml.entities.box)
				{
					add(new Box(o.@x, o.@y));
				}
			}
			
			if (xml.entities.elements("person").length() > 0)
			{
				for each (o in xml.entities.person)
				{
					add(new Person(o.@x, o.@y));
				}
			}
		}
		
	}

}