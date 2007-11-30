﻿/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;

import view.*;
import control.Controller;

class Application extends MovieClipHelper
{
	private function Application(mc:MovieClip)
	{
		super(ViewList.APPLICATION, mc);
		
		initialize(mc);
	}
	
	private function initialize(mc:MovieClip):Void
	{	
		Controller.getInstance().initialize();
		
		var tCube:CubeView = new CubeView(ViewList.CUBE, mc.createEmptyMovieClip("cube",10));
	}
	
	public static function main(mc:MovieClip) : Void 
	{
		Stage.align = "TL";
		Stage.scaleMode = "noScale";
		
		var o:Application = new Application(mc);
	}
}