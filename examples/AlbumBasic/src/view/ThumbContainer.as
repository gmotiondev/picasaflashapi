/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.EventBroadcaster;
import com.bourre.visual.MovieClipHelper;
import com.bourre.commands.Delegate;
import com.bourre.utils.Geom;

import control.*;

class view.ThumbContainer extends MovieClipHelper
{
	private var id:String;
	private var __b:MovieClip;
	public var title:String;
	
	public function ThumbContainer(aID:String, aContainer:MovieClip, aTitle:String)
	{
		super(aID, aContainer);
		
		id = aID;
		title = aTitle;
	}
	
	public function initialize():Void
	{
		view.onRelease = Delegate.create(this, onThumbRelease);
		view.onRollOver = Delegate.create(this, onThumbRollOver);
		view.onRollOut = Delegate.create(this, onThumbRollOut);
		setBackground(0xffffff, 0xe2007a, 5);	
	}
	
	private function setBackground(aColor:Number, aHighlight:Number, aMargin:Number):Void
	{
		__b = Geom.buildRectangle(view,2,(0+(1*aMargin)),(0+(1*aMargin)),aColor,aColor);
		__b._x = -aMargin;
		__b._y = -aMargin;
		__b.__c = aColor;
		__b.__h = aHighlight;
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
			tF.size = 11;
			tF.color = 0xffffff;
			tF.font = "Tahoma";
			
		view.createTextField("title_tf", 20, 0, 0, 100, 1);
		var tField:TextField = view.title_tf;
			tField.autoSize = "left";
			tField.multiline = true;
			tField.html = true;
			tField.background = true;
			tField.backgroundColor = 0xe2007a;
			tField.htmlText = title;
			
		tField.setTextFormat(tF);
		
		if(tField._width > (Stage.width - _root._xmouse)) {	tField._x -= tField._width; }
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
