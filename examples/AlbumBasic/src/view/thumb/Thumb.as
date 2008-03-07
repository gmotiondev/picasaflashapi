import com.bourre.events.IEvent;
import com.bourre.events.EventBroadcaster;
import com.bourre.visual.MovieClipHelper;
import com.bourre.commands.Delegate;
import com.bourre.utils.Geom;

import control.photo.PhotoChangedEvent;
import control.thumb.ThumbClickEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class view.thumb.Thumb extends MovieClipHelper
{
	private var t : TextField;
	private var b : MovieClip;
	private var id : String;
	private var title : String;
	
	public function Thumb(aId : String, aContainer : MovieClip, aTitle : String)
	{
		super(aId, aContainer);
		
		id = aId;
		title = aTitle;
	}
	
	public function initialize() : Void
	{
		view.onRelease = Delegate.create(this, onThumbRelease);
		view.onRollOver = Delegate.create(this, onThumbRollOver);
		view.onRollOut = Delegate.create(this, onThumbRollOut);
		
		setBackground(0xffffff, 0xe2007a, 5);	
	}
	
	private function setBackground(aColor : Number, aHighlight : Number, aMargin : Number) : Void
	{
		b = Geom.buildRectangle(view,2,(0+(1*aMargin)),(0+(1*aMargin)),aColor,aColor);
		b._x = -aMargin;
		b._y = -aMargin;
		b.color = aColor;
		b.highlight = aHighlight;
	}
	
	private function highlight(aTrigger : Boolean) : Void
	{
		with(new Color(b)) { setRGB((aTrigger ? b.highlight : b.color)); }
	}
	
	private function onThumbRelease() : Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new ThumbClickEvent(id));
	}
	
	private function onThumbRollOver() : Void
	{
		view.swapDepths(view._parent.getNextHighestDepth());
		
		var f : TextFormat = new TextFormat("kroeger", 8, 0xffffff);
			
		view.createTextField("tooltip", 20, 0, 0, 100, 1);
		t = view["tooltip"];
		t.embedFonts = true;
		t.autoSize = "left"; t.background = true; t.backgroundColor = 0xe2007a;
		t.text = title;
		t.setTextFormat(f);
		
		if(t._width > (Stage.width - _root._xmouse)) t._x -= t._width;
	}
	
	private function onThumbRollOut() : Void
	{
		t.removeTextField();
	}
	
	public function onInitialize(evt : IEvent) : Void
	{
		initialize();
	}

	public function photo_changed_event(evt : PhotoChangedEvent) : Void
	{	
		highlight(evt.id == id);
	}
}