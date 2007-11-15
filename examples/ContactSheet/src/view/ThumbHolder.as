import com.bourre.visual.MovieClipHelper;
import com.bourre.events.EventBroadcaster;
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.ILibListener;

import control.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class view.ThumbHolder extends MovieClipHelper implements ILibListener
{	
	public var grid:view.layout.GridLayout;
	
	/**
	 * Constructor 
	 */
	public function ThumbHolder(aId:String,aC:MovieClip)
	{
		super(aId,aC);
		initialize();
	}
	
	/**
	 * initialize point	 */
	private function initialize()
	{
		show();
		centerize();
	}
	
	public function setTitle(a:String):Void
	{			
		var tTF:TextFormat = new TextFormat();
			tTF.font = "kroeger";
			tTF.size = 8;
			tTF.color = 0x808080;
			
		view.createTextField("tf_album_title", 2, 0, -20, 320, 20);
		var tF:TextField = view["tf_album_title"];
			tF.embedFonts = true;
			tF.html = true;
			tF.htmlText = a;
			tF.setTextFormat(tTF);
	}

	private function centerize():Void
	{
		move(Math.round(Stage.width/2 - view._width/2), Math.round(Stage.height/2 - view._height/2));
	}
	
	// Listening to model
	public function resize_event(e:ResizeEvent):Void
	{
		centerize();
	}
	
	// Listening to Layout Manager
	public function complete():Void
	{
		centerize();
	}
	
	public function onLoadInit(e:LibEvent):Void
	{	
	}
	
	public function onLoadProgress(e:LibEvent):Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new ProgressSetEvent(e.getPerCent()));
	}
	
	public function onLoadComplete(e:LibEvent):Void
	{	
		grid.draw();
	}
	
	public function onTimeOut(e:LibEvent):Void
	{
		trace("ERROR: Photo loading time out: "+e.getName());
	}	
}
