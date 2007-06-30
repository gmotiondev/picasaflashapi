import com.bourre.visual.MovieClipHelper;
import com.bourre.events.IEvent;
import com.bourre.data.libs.GraphicLib;
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.LibStack;
import com.bourre.data.libs.ILibListener;
import com.bourre.data.collections.Map;
import com.bourre.transitions.TweenMS;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class uis.Photo extends MovieClipHelper implements ILibListener
{
	public var container:MovieClip;
	public var id:String;

	private static var __map:Map;
	
	public function Photo(aID:String, aContainer:MovieClip, aHide:Boolean)
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
	
	public function setTitle(aString:String):Void
	{
		var tTF:TextFormat = new TextFormat();
			tTF.font = "london";
			tTF.size = 14;
			tTF.leading = 6;
			tTF.color = 0xFFFFFF;
			
		container.createTextField("tf_"+id,2,10,440,620,40);
		var tF:TextField = container["tf_"+id];
			tF.embedFonts = true;
			tF.multiline = true;
			tF.html = true;
			tF.htmlText = ""+aString;
			tF.setTextFormat(tTF);
	}
	
	public function load(aUrl:String):Void
	{
		var tLibStack:LibStack = new LibStack();
		var tGL = new GraphicLib(view,1);
		
		tLibStack.enqueue(tGL, id, aUrl);		
		tLibStack.addListener(this);
		tLibStack.execute();
	}
	public static function exists(aID:String):Boolean
	{
		return __map.containsKey(aID);
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
	
	public function PhotoClick(e:IEvent)
	{
		//trace("uis.Photo.PhotoClick("+e+")",Log.INFO);
	}
	
	public function PhotoChanged(e:IEvent)
	{
		var tId = e.getTarget().getIdString();
		var t:TweenMS = null;
		
		if(tId == id)
		{
			t = new TweenMS(view, '_alpha', 100, 500, 0);
			show();
		} else
		{
			t = new TweenMS(view, '_alpha', 0, 500, 100);
			t.addEventListener(TweenMS.onMotionFinishedEVENT, this, hide);
		}
		t.start();
		
	}
}
