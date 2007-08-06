import com.bourre.visual.MovieClipHelper;
import com.bourre.events.IEvent;
import com.bourre.events.BasicEvent;
import com.bourre.events.EventBroadcaster;
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.ILibListener;
import com.bourre.data.collections.Map;
import com.bourre.transitions.TweenMS;
import com.bourre.utils.Geom;

import events.EventList;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class view.Photo extends MovieClipHelper implements ILibListener
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
		var tBG = Geom.buildRectangle(container,2,320,20, 0x9cdfff, 0x9cdfff);
			tBG._y = 197;
		var tTF:TextFormat = new TextFormat();
			tTF.font = "london";
			tTF.size = 14;
			tTF.leading = -16;
			tTF.blockIndent = 10;
			tTF.color = 0x003C63;
			
		container.createTextField("tf_"+id,5,0,200,320,20);
		var tF:TextField = container["tf_"+id];
			tF.embedFonts = true;
			tF.multiline = true;
			tF.html = true;
			tF.htmlText = ""+aString;
			tF.setTextFormat(tTF);
	}

	public static function exists(aID:String):Boolean
	{
		return __map.containsKey(aID);
	}

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
		trace("Photo loading time out: "+e.getName(),Log.ERROR);
	}
	
	public function PhotoClick(e:IEvent)
	{
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
