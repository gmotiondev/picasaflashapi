/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

import com.bourre.ioc.visual.AbstractMovieClipHelper;
import com.bourre.ioc.plugin.IPlugin;

class plugins.grid.view.dialog.SendDialog extends AbstractMovieClipHelper
{
	private var __desc:TextField;
	private var __from:TextField;
	private var __to:TextField;
	private var __send:MovieClip;
	
	public function SendDialog(owner:IPlugin, name:String, mc:MovieClip)
	{
		super(owner, name, mc);
		
		initialize();
	}
	
	private function initialize():Void
	{
		view.createTextField("description", 50, 0, 0, 320, 100);
		view.createTextField("from", 60, 0, 110, 320, 20);
		view.createTextField("to", 70, 0, 140, 320, 20);
		
		__desc = view.description;
		__from = view.from;
		__to = view.to;
		
		__send = view.attachMovie("s", "s", 8);
		__send._x = 0; __send._y = 170;
		
		decorate(__desc);
		decorate(__from);
		decorate(__to);
	}
	
	private function decorate(aField:TextField):Void
	{
		var tFormat = new TextFormat();
			tFormat.font = "kroeger";
			tFormat.size = 8;
			tFormat.color = 0xd40073;
		
		aField.background = true;
		aField.backgroundColor = 0xffffff;
		aField.border = true;
		aField.borderColor = 0xd40073
		aField.embedFonts = true;
		aField.multiline = true;
		aField.html = true;
		aField.htmlText = "empty";
		aField.wordWrap = true;
		aField.type = "input";
		aField.setTextFormat(tFormat);
	}
}