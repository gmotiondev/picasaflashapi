import com.bourre.visual.MovieClipHelper;
import com.bourre.log.PixlibStringifier;
import nbilyk.gui.layoutManagers.GridLayout;
import com.bourre.utils.Geom;

import view.ViewList;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class Application extends MovieClipHelper
{
	private function Application(mc:MovieClip)
	{
		super(ViewList.APPLICATION, mc);
		initialize(mc);
	}
	
	private function initialize(mc:MovieClip):Void
	{	
		trace("Up and running!");
		
		var lm:GridLayout = new GridLayout(mc, 2, 3);
		var mc1:MovieClip = Geom.buildRectangle(mc, 100, 200, 200, 0xff00ff, 0xff00ff);
		var mc2:MovieClip = Geom.buildRectangle(mc, 101, 150, 150, 0xaa00aa, 0xaa00aa);
		var mc3:MovieClip = Geom.buildRectangle(mc, 102, 100, 100, 0x770077, 0x770077);
	
		var mc4:MovieClip = Geom.buildRectangle(mc, 103, 100, 100, 0xffbbff, 0xffbbff);
		var mc5:MovieClip = Geom.buildRectangle(mc, 104, 150, 150, 0xaabbaa, 0xaabbaa);
		var mc6:MovieClip = Geom.buildRectangle(mc, 105, 100, 100, 0x77bb77, 0x77bb77);
		
		// Add your MovieClip(s) to the layout manager.
		lm.addObj(mc3);
		lm.addObj(mc1);
		lm.addObj(mc2);
		lm.addObj(mc4);
		lm.addObj(mc5);
		lm.addObj(mc6);
		lm.draw();		
	}
	
	public static function main(mc:MovieClip) : Void 
	{
		Stage.align = "TL";
		Stage.scaleMode = "noScale";
		
		var o:Application = new Application(mc);
	}
	
	public function toString():String 
	{
		return PixlibStringifier.stringify(this);
	}
}