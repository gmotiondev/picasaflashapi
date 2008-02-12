/**
 * @author michal.gron@gmail.com
 */
 
import com.bourre.ioc.visual.AbstractMovieClipHelper;
import com.bourre.ioc.plugin.IPlugin;
import com.bourre.data.libs.GraphicLib;
import com.bourre.commands.Delegate;
import com.bourre.visual.MovieClipHelper;
import com.bourre.utils.Geom;

import plugins.grid.control.PhotoClickEvent;
import plugins.grid.control.PhotoChangedEvent;

class plugins.grid.view.Thumb extends AbstractMovieClipHelper
{	
	public var id:String;
	public var summary:String;
	
	private var background:MovieClip;
	
	public function Thumb(owner:IPlugin, name:String, mc:MovieClip, aSummary:String)
	{
		super(owner, name, mc);
		//super(aId, aContainer)
		view.onRelease = Delegate.create(this, onThumbRelease);
		
		id = name;
		summary = aSummary;
		
		setBackground(0xffffff, 0xe2007a, 4);
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
	
	public function photo_changed_event(evt:PhotoChangedEvent):Void
	{	
		highlight(evt.id == id);
	}
	
	private function onThumbRelease():Void
	{
		getOwner().firePrivateEvent(new PhotoClickEvent(id));
	}
}