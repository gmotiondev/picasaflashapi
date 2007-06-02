import com.bourre.visual.MovieClipHelper;
import com.bourre.events.IEvent;
import com.bourre.data.libs.GraphicLib;
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.LibStack;
import com.bourre.data.libs.ILibListener;
import com.bourre.data.collections.Map;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class uis.Photo extends MovieClipHelper implements ILibListener
{
	public var container:MovieClip;
	public var id:String;

	private static var __map:Map;
	
	public function Photo(aID:String,aContainer:MovieClip,aHide:Boolean)
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
		container = aContainer.createEmptyMovieClip("p_"+id, aContainer.getNextHighestDepth());
		
		super(id, container);
		
		setVisible(!aHide);
		initialize();
	}
	
	private function initialize()
	{
	}
		
	public function load(aUrl:String):Void
	{
		var tLibStack:LibStack = new LibStack();
		var tGL = new GraphicLib(view,1);
		
		tLibStack.enqueue(tGL, id, aUrl);		
		tLibStack.addListener(this);
		tLibStack.execute();
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
		trace("Photo loading time out: "+e.getName(),Log.ERROR);
	}
	
	public function PhotoThumbClick(e:IEvent)
	{
		var tId = e.getTarget().getIdString();
		
		setVisible(tId == id);
	}
}
