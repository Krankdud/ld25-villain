package  
{
	import flash.utils.Dictionary;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class GameWorld extends World
	{
		private const DEATH_TIME:int = 120;
		private const SUCCESS_TIME:int = 180;
		
		private var _deathTimer:int;
		private var _successTimer:int;
		private var _hud:Hud;
		
		public function GameWorld() 
		{
			super();
			
			FP.screen.color = 0xd7eb96;
			Global.goalCurrent = 0;
			
			Global.particleManager = new ParticleManager();
			
			Global.levelFinished = false;
			Global.levelImpossible = false;
			
			loadLevel(Global.nextLevel);
			add(Global.particleManager);
			_hud = new Hud();
			add(_hud);
			
			_deathTimer = DEATH_TIME;
			_successTimer = SUCCESS_TIME;
			
			add(new VolumeControl());
		}
		
		override public function update():void
		{
			if (Input.pressed(Key.R) && !Global.levelFinished)
			{
				Global.nextLevel = Global.currentLevel;
				FP.world = new IntermissionWorld();
			}
			
			if (Input.pressed(Key.P))
			{
				Global.paused = !Global.paused;
			}
			
			if (Global.paused)
			{
				_hud.update();
				_hud.render();
			}
			else
			{
				Global.camera.update();
				
				if (Global.playerDead && !Global.levelFinished)
				{
					if (_deathTimer <= 0)
					{
						Global.nextLevel = Global.currentLevel;
						FP.world = new IntermissionWorld();
					}
					_deathTimer--;
				}
				
				if (Global.goalCurrent >= Global.goalAmount)
				{
					Global.levelFinished = true;
				}
				
				if (Global.levelFinished)
				{
					if (_successTimer <= 0)
					{
						if (Global.nextLevel == "end")
							FP.world = new EndWorld();
						else
							FP.world = new IntermissionWorld();
					}
					else
						_successTimer--;
						
					if (_successTimer == 179)
						Resources.sfxLevelfinish.play();
				}
				
				// Impossible checker
				if (Global.goalType == Global.GOAL_GOATS)
				{
					if (classCount(Goat) + Global.goalCurrent < Global.goalAmount)
						Global.levelImpossible = true;
				}
				else
				{
					if (classCount(Person) + Global.goalCurrent < Global.goalAmount)
						Global.levelImpossible = true;
				}
				
				super.update();
			}
		}
		
		public function loadLevel(level:String):void
		{
			var xml:XML = new XML(new (Resources.getLevelFromString(level)));
			
			Global.levelWidth = xml.@width;
			Global.levelHeight = xml.@height;
			
			Global.currentLevel = Global.nextLevel;
			Global.nextLevel = xml.@nextLevel;
			var s:String = xml.@mission;
			switch (s)
			{
				case "abduct":
					Global.goalType = Global.GOAL_ABDUCT;
					break;
				case "squish":
					Global.goalType = Global.GOAL_SQUISH;
					break;
				case "goats":
					Global.goalType = Global.GOAL_GOATS;
					break;
			}
			Global.goalAmount = xml.@goal;
			
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
			
			if (xml.entities.elements("goat").length() > 0)
			{
				for each (o in xml.entities.goat)
				{
					add(new Goat(o.@x, o.@y));
				}
			}
			
			if (xml.entities.elements("bat").length() > 0)
			{
				for each (o in xml.entities.bat)
				{
					add(new Bat(o.@x, o.@y));
				}
			}
			
			if (xml.entities.elements("turret").length() > 0)
			{
				for each (o in xml.entities.turret)
				{
					add(new Turret(o.@x, o.@y));
				}
			}
			
			if (xml.entities.elements("hurt").length() > 0)
			{
				for each (o in xml.entities.hurt)
				{
					addMask(new Hitbox(o.@width, o.@height), "enemy", o.@x, o.@y);
				}
			}
			
			// Triggered stuff
			var trigger:Array = new Array();
			
			if (xml.entities.elements("bars").length() > 0)
			{
				for each (o in xml.entities.bars)
				{
					trigger[o.@triggerid] = new Bars(o.@x, o.@y, o.@height);
					add(trigger[o.@triggerid]);
				}
			}
			
			if (xml.entities.elements("button").length() > 0)
			{
				for each (o in xml.entities.button)
				{
					var b:Button = new Button(o.@x, o.@y);
					b.setTarget(trigger[o.@triggerid]);
					add(b);
				}
			}
		}
		
	}

}