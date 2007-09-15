import com.bourre.visual.MovieClipHelper;
import com.bourre.events.IEvent;
import com.bourre.events.BasicEvent;
import com.bourre.events.EventBroadcaster;
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.ILibListener;
import com.bourre.data.collections.Map;
import com.bourre.utils.Geom;
import com.bourre.commands.Delegate;

import events.EventList;
import view.Tooltip;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class view.Thumb extends MovieClipHelper implements ILibListener
{
	public var container:MovieClip;
	public var margin:Number = 10;
	public var id:String;
	
	private var __b:MovieClip;
	private var __type:String = null;
	private var __albumid:String = null;
	private var __size:Object = {w:0,h:0};
	
	private static var __map:Map;
	
	public function Thumb(aID:String,aContainer:MovieClip,aHide:Boolean)
	{
		if(__map == undefined) {
			__map = new Map();
		}
		
		if(__map.containsKey(aID))
		{
			return;
		} else
		{
			__map.put(aID, this);
		}
		
		id = aID;
		container = aContainer.createEmptyMovieClip(id,aContainer.getNextHighestDepth());
		super(id, container);
		
		setVisible(!aHide);
	}
		
	private function initialize()
	{
		setBackground(0x1A1A1A, 0x808080, 4);
	}
	
	public function setBackground(aColor:Number, aHighlight:Number, aMargin:Number):Void
	{
		__b = Geom.buildRectangle(view,10,(__size.w+(2*aMargin)),(__size.h+(2*aMargin)),aColor,aColor);
		__b._x = -aMargin;
		__b._y = -aMargin;
		__b.__c = aColor;
		__b.__h = aHighlight;
	}
	
	public function setTitle(aString:String):Void
	{
		container.createTextField("tf_"+id,2,100,0,200,100);
		var tField:TextField = container["tf_"+id];
			tField.multiline = true;
			tField.html = true;
			tField.htmlText = "<font face=\"Tahoma\">"+aString+"</font>";
	}
	
	public function setSize(w:Number,h:Number):Void
	{
		__size = {w:w, h:h};
		initialize();
	}
	
	public function getButton():MovieClip
	{
		return container;
	}
	
	public function getThumbs():Map
	{
		return __map;
	}
	
	public static function getThumb(aID:String):Thumb 
	{
		return __map.get(aID);
	}
	
	public static function exists(aID:String):Boolean
	{
		return __map.containsKey(aID);
	}
	
	private function highlight(aTrigger:Boolean):Void
	{
		with(new Color(__b)) { setRGB((aTrigger ? __b.__h : __b.__c)); }
	}
	/**
	 * Listen to LibStatck	 */
	public function onLoadStart(e:LibEvent):Void
	{
	}
	
	public function onLoadInit(e:LibEvent):Void
	{
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
		trace("ERROR: Thumb loading time out: "+e.getName());
	}
	/**
	 * Listen to Model	 */
	public function PhotoThumbClick(e:IEvent):Void
	{
		highlight(e.getTarget().getIdString() == id);
	}
}
