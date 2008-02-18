/**
 * @author michal.gron@gmail.com
 */
import com.bourre.ioc.visual.AbstractMovieClipHelper;
import com.bourre.ioc.plugin.IPlugin;

import com.bourre.utils.Geom;

class plugins.grid.view.dialog.SendingDialog extends AbstractMovieClipHelper
{	
	public function SendingDialog(owner:IPlugin, name:String, mc:MovieClip)
	{
		super(owner, "sending_dialog_"+name, mc);
		
		initialize();
	}
	
	private function initialize():Void
	{
		view.createTextField("status", 50, 0, 0, 320, 100);
		view.status.text = "Sending email...";
		
		decorate(view.status);
		
		setBackground(0xffffff, 0xffffff, 10);
	}
	
	private function setBackground(aColor:Number, aHighlight:Number, aMargin:Number):Void
	{		
		var tBackground:MovieClip = Geom.buildRectangle(view, 4, (view._width+(2*aMargin)), (view._height+(2*aMargin)),aColor, aColor);
			tBackground._x = -aMargin;
			tBackground._y = -aMargin;
			tBackground.__c = aColor;
			tBackground.__h = aHighlight;
	}
	
	private function decorate(aField:TextField):Void
	{
		var tFormat = new TextFormat();
			tFormat.font = "kroeger";
			tFormat.size = 8;
			tFormat.color = 0xd40073;
		
		aField.background = true;
		aField.backgroundColor = 0xffffff;
		aField.embedFonts = true;
		aField.multiline = true;
		aField.html = true;
		aField.htmlText = "sending email";
		aField.wordWrap = true;
		aField.setTextFormat(tFormat);
	}
}