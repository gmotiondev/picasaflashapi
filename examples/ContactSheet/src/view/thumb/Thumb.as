import com.bourre.utils.Geom;
import com.bourre.visual.MovieClipHelper;
import com.bourre.events.EventBroadcaster;
import com.bourre.commands.Delegate;

import control.thumb.*;
import control.photo.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class view.thumb.Thumb extends MovieClipHelper
{
	private var id : String;
	private var b : MovieClip;
	private var c : Number = 0xffffff;
	private var h : Number = 0xd40073;
	
	public function Thumb(aId : String, aC : MovieClip)
	{
		super("thumb_" + aId, aC);
		
		id = aId;
		
		setBackground(c, h, 4);
		view.onRelease = Delegate.create(this, onThumbRelease);
	}
	
	private function setBackground(aColor : Number, aHighlight : Number, aMargin : Number) : Void
	{
		b = Geom.buildRectangle(view, 2, (0+(2*aMargin)), (0+(2*aMargin)), aColor, aColor);
		b._x = -aMargin;
		b._y = -aMargin;
		b["color"] = aColor;
		b["highlight"] = aHighlight;
	}
		
	private function set highlight(a : Boolean) : Void
	{
		with(new Color(b)) { setRGB((a ? b["highlight"] : b["color"])); }
	}
	
	private function onThumbRelease() : Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new ThumbClickEvent(id));
	}
	
	private function photo_changed_event(evt : PhotoChangedEvent) : Void
	{
		highlight = (evt.id == id);
	}
}