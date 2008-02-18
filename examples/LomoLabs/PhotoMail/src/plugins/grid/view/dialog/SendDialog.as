/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

import com.bourre.ioc.visual.AbstractMovieClipHelper;
import com.bourre.ioc.plugin.IPlugin;

import com.bourre.utils.Geom;
import com.bourre.commands.Delegate;

import plugins.grid.control.PhotoSendEvent;
import plugins.grid.control.dialog.GetSendDialogEvent;

class plugins.grid.view.dialog.SendDialog extends AbstractMovieClipHelper
{
	private var __desc:TextField;
	private var __from:TextField;
	private var __to:TextField;
	private var __id:String;
	
	public function SendDialog(owner:IPlugin, name:String, mc:MovieClip)
	{
		super(owner, "send_dialog_"+name, mc);
		
		__id = name;
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
		
		var tSend:MovieClip = view.attachMovie("s", "s", 80);
			tSend._x = 0; tSend._y = 170;
			tSend.onRelease = Delegate.create(this, onSend);
		
		var tClose:MovieClip = view.attachMovie("h", "h", 90);
			tClose._x = tSend._x + tSend._width + 5; tClose._y = 170;
			tClose.onRelease = Delegate.create(this, onClose);
			
		decorate(__desc, "", true);
		decorate(__from, "from@you.com", false);
		decorate(__to, "to@someone.com", false);
		
		setBackground(0xffffff, 0xffffff, 10);
	}
	
	public function set summary(aSummary:String):Void
	{
		decorate(__desc, "Sending \""+aSummary+"\" to you", true);
	}
	
	private function setBackground(aColor:Number, aHighlight:Number, aMargin:Number):Void
	{		
		var tBackground:MovieClip = Geom.buildRectangle(view, 4, (view._width+(2*aMargin)), (view._height+(2*aMargin)),aColor, aColor);
			tBackground._x = -aMargin;
			tBackground._y = -aMargin;
			tBackground.__c = aColor;
			tBackground.__h = aHighlight;
	}
	
	private function decorate(aField:TextField, aText:String, aMultiline:Boolean):Void
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
		aField.multiline = aMultiline;
		aField.text = aText;
		aField.wordWrap = true;
		aField.type = "input";
		aField.setTextFormat(tFormat);
	}
	
	private function onSend():Void
	{
		getOwner().firePrivateEvent(new PhotoSendEvent(getOwner(), __from.text, __to.text, __desc.text, __id));
	}
	
	private function onClose():Void
	{
		view.removeMovieClip();
		
		getOwner().firePrivateEvent(new GetSendDialogEvent(getOwner(), null));
	}
}