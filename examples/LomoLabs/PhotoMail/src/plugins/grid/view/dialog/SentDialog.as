/**
 * @author michal.gron@gmail.com
 */
import com.bourre.ioc.visual.AbstractMovieClipHelper;
import com.bourre.ioc.plugin.IPlugin;

import com.bourre.utils.Geom;
import com.bourre.commands.Delegate;

import plugins.grid.control.dialog.GetSentDialogEvent;

class plugins.grid.view.dialog.SentDialog extends AbstractMovieClipHelper
{	
	public function SentDialog(owner:IPlugin, name:String, mc:MovieClip, aMessage:String)
	{
		super(owner, "sent_dialog_"+name, mc);
		
		initialize(aMessage);
	}
	
	private function initialize(aMessage:String):Void
	{
		view.createTextField("status", 50, 0, 0, 320, 100);
		
		decorate(view.status, aMessage);
		
		var tClose:MovieClip = view.attachMovie("h", "h", 90);
			tClose._x = 0; tClose._y = 170;
			tClose.onRelease = Delegate.create(this, onClose);
			
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
	
	private function decorate(aField:TextField, aMessage:String):Void
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
		aField.htmlText = aMessage;
		aField.wordWrap = true;
		aField.setTextFormat(tFormat);
	}
	
	private function onClose():Void
	{		
		getOwner().firePrivateEvent(new GetSentDialogEvent(getOwner(), null));	
	}
}