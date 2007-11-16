/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.EventBroadcaster;
import com.bourre.visual.MovieClipHelper;
import com.bourre.transitions.TweenMS;
import com.bourre.commands.Delegate;
import com.bourre.utils.Geom;

import control.*;

class view.ThumbContainer extends MovieClipHelper
{
	private var id:String;
	private var __b:MovieClip;
	public var title:String;
	private var title_tf:TextField;
	
	public function ThumbContainer(aID:String, aContainer:MovieClip, aTitle:String)
	{
		super(aID, aContainer);
		
		id = aID;
		title = aTitle;
		
		setBackground(0xffffff, 0xe2007a, 4);
		view.onRelease = Delegate.create(this, onThumbRelease);
		view.onRollOver = Delegate.create(this, onThumbRollOver);
		view.onRollOut = Delegate.create(this, onThumbRollOut);	
	}
	
	public function setBackground(aColor:Number, aHighlight:Number, aMargin:Number):Void
	{
		__b = Geom.buildRectangle(view,2,(10+(2*aMargin)),(10+(2*aMargin)),aColor,aColor);
		__b._x = -aMargin;
		__b._y = -aMargin;
		__b.__c = aColor;
		__b.__h = aHighlight;
	}
	
	public function setTitle(aString:String):Void
	{
	}
	
	private function highlight(aTrigger:Boolean):Void
	{
		with(new Color(__b)) { setRGB((aTrigger ? __b.__h : __b.__c)); }
	}
	
	private function onThumbRelease():Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new PhotoClickEvent(id));
	}
	
	private function onThumbRollOver():Void
	{
		view.swapDepths(view._parent.getNextHighestDepth());
		
		var tF:TextFormat = new TextFormat();
			tF.size = 14;
			tF.color = 0xffffff;
			tF.font = "london";
			
		view.createTextField("title_tf", 20, 0, 0, 100, 1);
		var tField:TextField = view.title_tf;
			tField.autoSize = "left";
			tField.embedFonts = true;
			tField.multiline = true;
			tField.html = true;
			tField.background = true;
			tField.backgroundColor = 0xe2007a;
			tField.htmlText = title;
			
		tField.setTextFormat(tF);
	}
	
	private function onThumbRollOut():Void
	{
		view.title_tf.removeTextField();
	}
	
	// listen to the model
	public function photo_changed_event(e:PhotoChangedEvent):Void
	{	
		highlight(PhotoChangedEvent(e).id == id);
	}
}
