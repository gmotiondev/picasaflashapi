/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class content.loader.loader
{
	private function loader(mc:MovieClip)
	{
		trace("loader is up and running!");
		
		mc.createEmptyMovieClip("cb",1); 
		
		mc.cb.onNameCallBack = function(){ trace("onNameCallBack"); }
		mc.cb.onProgressCallback = function(){ trace("onProgressCallback"); }
		mc.cb.onBuildCallback = function() { trace("onBuildCallback"); }
	}
	
	public static function main(mc:MovieClip):Void
	{
		var o:loader = new loader(mc);
	}
}