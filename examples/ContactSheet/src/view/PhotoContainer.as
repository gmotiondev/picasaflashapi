import com.bourre.events.EventBroadcaster;
import com.bourre.visual.MovieClipHelper;
import com.bourre.visual.ScreenProtectionUI 
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.ILibListener;
import com.bourre.data.libs.LibStack;
import com.bourre.data.libs.GraphicLib;
import com.bourre.commands.Delegate;
import com.bourre.utils.Geom;

import control.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class view.PhotoContainer extends MovieClipHelper implements ILibListener
{
	public var id:String;
	public var url:String;
	public var title:String;
	private var __b:MovieClip;
	
	private var loaded:Boolean = false;

	public function PhotoContainer(aID:String, aContainer:MovieClip, aHide:Boolean, aUrl:String, aTitle:String)
	{
		super(aID, aContainer);
		
		id = aID;
		url = aUrl;
		title = aTitle;	
		setVisible(!aHide);
	}
	
	private function setTitle():Void
	{		
		var tTF:TextFormat = new TextFormat();
			tTF.font = "kroeger";
			tTF.size = 8;
			tTF.color = 0xd40073;
			
		view.createTextField("title_tf", 15, 0, -20, 320, 20);
		var tF:TextField = view.title_tf;
			tF.embedFonts = true;
			tF.html = true;
			tF.htmlText = title;
			tF.setTextFormat(tTF);
	}
		
	/**
	 * set background
	 */
	private function setBackground(aColor:Number, aHighlight:Number, aMargin:Number):Void
	{
		var tTopbar:Number = 15;
		__b = Geom.buildRectangle(view,4,(view._width+(2*aMargin)),(view._height+(2*aMargin) + tTopbar),aColor,aColor);
		__b._x = -aMargin;
		__b._y = -aMargin - tTopbar;
		__b.__c = aColor;
		__b.__h = aHighlight;
	}
	
	private function close():Void
	{
		//EventBroadcaster.getInstance().broadcastEvent(new BasicEvent(EventList.ON_CLOSE_PHOTO));
		hide();
		unprotect();
	}
	
	private function load():Void
	{
		var tLibStack:LibStack = new LibStack();
		tLibStack.enqueue(new GraphicLib(view, 5), id, url);
		tLibStack.addListener(this);
		tLibStack.execute();
	}
	
	public function onLoadInit(e:LibEvent):Void
	{
		loaded = true;
		trace(id+" loaded");
	}
	
	public function onLoadProgress(e:LibEvent):Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new ProgressSetEvent(e.getPerCent()));
	}
	
	public function onLoadComplete(e:LibEvent):Void
	{	
		setBackground(0xffffff, 0xffffff, 10);
		setTitle();
		
		var tClose = view.attachMovie("c","c",210);
			tClose._x = view._width - 33;
			tClose._y = -17;
			tClose.onRelease = Delegate.create(this, close);
			
		centerize();
	} 
	
	public function onTimeOut(e:LibEvent):Void
	{
		trace("ERROR: Photo loading time out: "+e.getName());
	}
	
	// listen to the model
	public function photo_changed_event(e:PhotoChangedEvent):Void
	{
		if(PhotoChangedEvent(e).id == id)
		{
			if(!loaded) load();
				
			show();
			centerize();
			protect();
		} else
		{
			if(isVisible())
			{
				hide();
			}
		}
	}
	
	private function centerize():Void
	{
		move(Math.round(Stage.width/2 - view._width/2 + 10), Math.round(Stage.height/2 - view._height/2));
	}
	
	// Listening to model
	public function resize_event(e:ResizeEvent):Void
	{
		centerize();
	}
	
	private function protect():Void
	{
		var tProtection:MovieClipHelper = new ScreenProtectionUI(_level0,6,"protection");
			tProtection.view._alpha = 20;
	}
	
	private function unprotect():Void
	{
		var tProtection:MovieClipHelper = MovieClipHelper.getMovieClipHelper("protection");
			tProtection.release();
	}
}
