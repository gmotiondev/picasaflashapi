/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.EventBroadcaster;
import com.bourre.visual.MovieClipHelper;
import com.bourre.transitions.TweenMS;
import com.bourre.commands.Delegate;
import com.bourre.utils.Geom;
import com.bourre.data.libs.LibStack;

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
	
	// dispatch event to command the model.. 
	private function onThumbRelease():Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new PhotoClickEvent(id));
	}
	
	// listen to the model
	public function photo_changed_event(e:PhotoChangedEvent):Void
	{	
		highlight(PhotoChangedEvent(e).id == id);
	}
}
