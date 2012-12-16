package  
{
    import net.flashpunk.Sfx;
    import flash.utils.Dictionary;
    
    public class Resources 
    {
        [Embed(source = "data/graphics/bars.png")] static public const IMG_BARS:Class;
        [Embed(source = "data/graphics/bat.png")] static public const IMG_BAT:Class;
        [Embed(source = "data/graphics/box.png")] static public const IMG_BOX:Class;
        [Embed(source = "data/graphics/bullet.png")] static public const IMG_BULLET:Class;
        [Embed(source = "data/graphics/button.png")] static public const IMG_BUTTON:Class;
        [Embed(source = "data/graphics/efx_abduct.png")] static public const IMG_EFX_ABDUCT:Class;
        [Embed(source = "data/graphics/goat.png")] static public const IMG_GOAT:Class;
        [Embed(source = "data/graphics/person.png")] static public const IMG_PERSON:Class;
        [Embed(source = "data/graphics/tileset.png")] static public const IMG_TILESET:Class;
        [Embed(source = "data/graphics/turret.png")] static public const IMG_TURRET:Class;
        [Embed(source = "data/graphics/ufo.png")] static public const IMG_UFO:Class;
        [Embed(source = "data/levels/level01.oel", mimeType = "application/octet-stream")] static public const LVL_LEVEL01:Class;
        [Embed(source = "data/levels/level02.oel", mimeType = "application/octet-stream")] static public const LVL_LEVEL02:Class;
        [Embed(source = "data/levels/level03.oel", mimeType = "application/octet-stream")] static public const LVL_LEVEL03:Class;
        [Embed(source = "data/levels/level04.oel", mimeType = "application/octet-stream")] static public const LVL_LEVEL04:Class;
        [Embed(source = "data/levels/level05.oel", mimeType = "application/octet-stream")] static public const LVL_LEVEL05:Class;
        [Embed(source = "data/levels/level06.oel", mimeType = "application/octet-stream")] static public const LVL_LEVEL06:Class;
        [Embed(source = "data/levels/level07.oel", mimeType = "application/octet-stream")] static public const LVL_LEVEL07:Class;
        [Embed(source = "data/levels/level08.oel", mimeType = "application/octet-stream")] static public const LVL_LEVEL08:Class;
        [Embed(source = "data/levels/level09.oel", mimeType = "application/octet-stream")] static public const LVL_LEVEL09:Class;
        [Embed(source = "data/levels/level10.oel", mimeType = "application/octet-stream")] static public const LVL_LEVEL10:Class;
        [Embed(source = "data/levels/testlevel.oel", mimeType = "application/octet-stream")] static public const LVL_TESTLEVEL:Class;
        [Embed(source = "data/levels/testlevel2.oel", mimeType = "application/octet-stream")] static public const LVL_TESTLEVEL2:Class;
        
        static private var _levelDictionary:Dictionary;

        public function Resources() 
        {
            
        }
        
        static public function init():void
        {
            _levelDictionary = new Dictionary();
            _levelDictionary["level01"] = LVL_LEVEL01;
            _levelDictionary["level02"] = LVL_LEVEL02;
            _levelDictionary["level03"] = LVL_LEVEL03;
            _levelDictionary["level04"] = LVL_LEVEL04;
            _levelDictionary["level05"] = LVL_LEVEL05;
            _levelDictionary["level06"] = LVL_LEVEL06;
            _levelDictionary["level07"] = LVL_LEVEL07;
            _levelDictionary["level08"] = LVL_LEVEL08;
            _levelDictionary["level09"] = LVL_LEVEL09;
            _levelDictionary["level10"] = LVL_LEVEL10;
            _levelDictionary["testlevel"] = LVL_TESTLEVEL;
            _levelDictionary["testlevel2"] = LVL_TESTLEVEL2;
        }
        
        static public function getLevelFromString(s:String):Class
        {
            return _levelDictionary[s];
        }
        
    }

}