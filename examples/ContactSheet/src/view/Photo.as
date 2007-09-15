import com.bourre.visual.MovieClipHelper;
import com.bourre.visual.ScreenProtectionUI 
import com.bourre.events.IEvent;
import com.bourre.events.BasicEvent;
import com.bourre.events.EventBroadcaster;
import com.bourre.data.libs.GraphicLib;
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.LibStack;
import com.bourre.data.libs.ILibListener;
import com.bourre.data.collections.Map;
import com.bourre.transitions.TweenMS;
import com.bourre.utils.Geom;
import com.bourre.commands.Delegate;

import events.EventList;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class view.Photo extends MovieClipHelper implements ILibListener
{
	public var container:MovieClip;
	public var id:String;
	public var url:String;
	private var loaded:Boolean = false;
	private var __b:MovieClip;
	private var __size:Object;
	private static var __map:Map;
	
	public function Photo(aID:String, aLink:String, aContainer:MovieClip, aHide:Boolean)
	{
		if(__map == undefined) {
			__map = new Map();
		}		

		if(__map.containsKey(aID))
		{
			trace("Photo "+aID+" already exists! Skipping!",Log.WARNING);
			return;
		} else {
			__map.put(aID, this);
		}

		id = aID;
		url = aLink;
		container = aContainer.createEmptyMovieClip("p_"+id, 100 + aContainer.getNextHighestDepth());
		
		super(id, container);
		
		setVisible(aHide);
		initialize();
	}
	
	private function initialize()
	{
		setBackground(0x1A1A1A, 0x1A1A1A, 10);
		
		var tClose = view.attachMovie("c","c",210);
			tClose._x = view._width - 33;
			tClose._y = -17;
			tClose.onRelease = Delegate.create(this, close);
	}
	
	public function setTitle(aString:String):Void
	{
		container.createTextField("tf_"+id,25,200,500,200,100);
		var tField:TextField = container["tf_"+id];
			tField.multiline = true;
			tField.html = true;
			tField.htmlText = "<font face=\"Tahoma\">"+aString+"</font>";
	}
	
	public function setBackground(aColor:Number, aHighlight:Number, aMargin:Number):Void
	{
		var tTopbar:Number = 15;
		__b = Geom.buildRectangle(view,10,(__size.w+(2*aMargin)),(__size.h+(2*aMargin) + tTopbar),aColor,aColor);
		__b._x = -aMargin;
		__b._y = -aMargin - tTopbar;
		__b.__c = aColor;
		__b.__h = aHighlight;
	}

	public function setSize(w:Number,h:Number):Void
	{
		__size = {w:w, h:h};
		
		initialize();
	}

	public function load():Void
	{
		trace("load: "+url)
		var tLibStack:LibStack = new LibStack();
		var tGL = new GraphicLib(view,99);
		
		tLibStack.enqueue(tGL, id, url);
		tLibStack.addListener(this);
		tLibStack.execute();
	}
	public function close():Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new BasicEvent(EventList.ON_CLOSE_PHOTO));
	}
	// Listener methods
	public function onLoadStart(e:LibEvent):Void
	{
	}
	
	public function onLoadInit(e:LibEvent):Void
	{
		loaded = true;
		centerize();
	}
	
	public function onLoadProgress(e:LibEvent):Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new BasicEvent(EventList.SET_LOADER_PROGRESS,e.getPerCent()));
	}
	
	public function onLoadComplete(e:LibEvent):Void
	{	
	} 
	
	public function onTimeOut(e:LibEvent):Void
	{
		trace("Photo loading time out: "+e.getName(),Log.ERROR);
	}
	
	public function PhotoThumbClick(e:IEvent)
	{	
		var tId = e.getTarget().getIdString();
		
		if(!loaded && tId == id) load();
		
		if(tId == id)
		{
			show();
			centerize();
			protect();
		} else
		{
			hide();
		}
		
	}
	public function OnClosePhoto(e:IEvent):Void
	{
		if(e.getTarget() == id)
		{
			hide();
			unprotect();
		}
	}
	/**
	 * 
	 */
	private function centerize():Void
	{
		move((Stage.width/2 - view._width/2), (Stage.height/2 - view._height/2));
	}
	/**
	 * Listening to model
	 */
	public function onResize(e:IEvent):Void
	{
		centerize();
	}
	private function protect():Void
	{
		var tProtection:MovieClipHelper = new ScreenProtectionUI(_level0,6,"protection");
			tProtection.view._alpha = 80;
	}
	private function unprotect():Void
	{
		var tProtection:MovieClipHelper = MovieClipHelper.getMovieClipHelper("protection");
			tProtection.release();
	}
}
