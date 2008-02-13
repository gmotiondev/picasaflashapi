/**
 * @author michal.gron@gmail.com
 */
 
import com.bourre.ioc.visual.AbstractMovieClipHelper;
import com.bourre.ioc.plugin.IPlugin;
import com.bourre.commands.Delegate;
import com.bourre.utils.Geom;

import plugins.grid.control.PhotoClickEvent;
import plugins.grid.control.PhotoChangedEvent;

class plugins.grid.view.Thumb extends AbstractMovieClipHelper
{	
	public var id:String;
	private var background:MovieClip;
	
	public function Thumb(owner:IPlugin, name:String, mc:MovieClip)
	{
		super(owner, name, mc);

		id = name;		
		setBackground(0xffffff, 0xe2007a, 4);
		view.onRelease = Delegate.create(this, onThumbRelease);
	}
	
	private function setBackground(aColor:Number, aHighlight:Number, aMargin:Number):Void
	{
		background = Geom.buildRectangle(view, 2, (0+(2*aMargin)), (0+(2*aMargin)), aColor, aColor);
		background._x = -aMargin;
		background._y = -aMargin;
		background.__c = aColor;
		background.__h = aHighlight;
	}
	
	private function highlight(b:Boolean):Void
	{
		with(new Color(background)) { setRGB((b ? background.__h : background.__c)); }
	}
	
	private function onThumbRelease():Void
	{
		getOwner().firePrivateEvent(new PhotoClickEvent(id));
	}
	
	public function photo_changed_event(evt:PhotoChangedEvent):Void
	{	
		highlight(evt.id == id);
	}
}