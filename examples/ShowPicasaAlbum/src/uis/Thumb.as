import com.bourre.visual.MovieClipHelper;
import com.bourre.events.IEvent;
import com.bourre.data.libs.GraphicLib;
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.LibStack;
import com.bourre.data.libs.ILibListener;
import com.bourre.data.collections.Map;
import com.bourre.utils.Geom;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class uis.Thumb extends MovieClipHelper implements ILibListener
{
	public var container:MovieClip;
	public var margin:Number = 10;
	public var id:String;
	
	private var __background:MovieClip;
	private var __type:String = null;
	private var __albumid:String = null;
	
	private static var __map:Map;
	
	public function Thumb(aID:String,aContainer:MovieClip,aHide:Boolean)
	{
		if(__map == undefined) {
			__map = new Map();
		}
		
		if(__map.containsKey(aID))
		{
			return;
		} else {
			__map.put(aID, this);
		}
		
		id = aID;
		container = aContainer.createEmptyMovieClip(id,aContainer.getNextHighestDepth());
		super(id, container);
		
		setVisible(!aHide);	
		initialize();
	}
	
	private function initialize()
	{
		__background = Geom.buildRectangle(view,10,82,64,0xcccccc,0xcccccc);
		__background._x = -5;		__background._y = -5;
	}
	
	public function setTitle(aString:String):Void
	{
		container.createTextField("tf_"+id,2,100,0,200,100);
		var tField:TextField = container["tf_"+id];
			tField.multiline = true;
			tField.html = true;
			tField.htmlText = "<font face=\"Tahoma\">"+aString+"</font>";
	}
	
	public function getButton():MovieClip
	{
		return container;
	}
	
	public function load(aUrl:String):Void
	{
		var tLibStack:LibStack = new LibStack();
		var tGL = new GraphicLib(view,100);
		
		tLibStack.enqueue(tGL, id, aUrl);		
		tLibStack.addListener(this);
		tLibStack.execute();
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
		with(new Color(__background)) { setRGB((aTrigger ? 0x008000 : 0xcccccc)); }
	}
	// Listener methods
	public function onLoadStart(e:LibEvent):Void
	{
	}
	
	public function onLoadInit(e:LibEvent):Void
	{
	}
	
	public function onLoadProgress(e:LibEvent):Void
	{
		//view.onLoadProgress({progress:e.getPerCent()});
	}
	
	public function onLoadComplete(e:LibEvent):Void
	{	
	} 
	
	public function onTimeOut(e:LibEvent):Void
	{
		trace("Thumb loading time out: "+e.getName(),Log.ERROR);
	}
	
	public function PhotoThumbClick(e:IEvent):Void
	{
		//e.g. highlight the current selected photo thumb
		//trace("uis.Thumb.PhotoThumbClick("+e+")",Log.INFO);
		highlight(e.getTarget().getIdString() == id);
	}
}
