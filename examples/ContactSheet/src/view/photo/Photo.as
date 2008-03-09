import com.bourre.events.EventBroadcaster; 
import com.bourre.commands.Delegate;
import com.bourre.visual.*; 
import com.bourre.data.libs.*;
import com.bourre.utils.Geom;

import gs.TweenLite;

import control.*;
import control.photo.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class view.photo.Photo extends MovieClipHelper implements ILibListener
{
	private var id : String;
	private var url : String;
	private var title : String;
	private var loaded : Boolean = false;
	
	public function Photo(aId : String, aC : MovieClip, aUrl : String)
	{	
		super("photo_" + aId, aC);
		
		id = aId;
		url = aUrl;
		
		hide();
	}
	
	private function setBackground(aColor : Number, aMargin : Number) : Void
	{
		var tTopbar : Number = 15;
		var b : MovieClip = Geom.buildRectangle(view, 4, (view._width+(2*aMargin)), (view._height+(2*aMargin) + tTopbar), aColor, aColor);
			b._x = -aMargin;
			b._y = -aMargin - tTopbar;
	}
	
	private function setTitle() : Void
	{
		view.createTextField("title_tf", 15, 0, -20, 1, 1);
		
		var f : TextFormat = new TextFormat("kroeger", 8, 0xd40073);			
		var t : TextField = view["title_tf"];
			t.embedFonts = true;
			t.autoSize = "left";
			t.text = title;
			t.setTextFormat(f);
	}
	
	private function close() : Void
	{
		hide();
		unprotect();
	}
	
	private function centerize() : Void
	{
		TweenLite.to(view, 0.5, {_x : Math.round((Stage.width - view._width)/2), _y : Math.round((Stage.height - view._height)/2)});
	}
	
	private function protect() : Void
	{
		var p : MovieClipHelper = new ScreenProtectionUI(_level0, 6, "protection");
			p.view._alpha = 20;
	}
	
	private function unprotect() : Void
	{
		var p : MovieClipHelper = MovieClipHelper.getMovieClipHelper("protection");
			p.release();
	}
	
	private function load() : Void
	{
		var s : LibStack = new LibStack();
		
		s.enqueue(new GraphicLib(view, 5), id, url);
		s.addListener(this);
		s.execute();
	}
	
	public function onLoadInit(evt : LibEvent) : Void
	{
		loaded = true;
	}
	
	public function onLoadProgress(evt : LibEvent) : Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new ProgressEvent(evt.getPerCent()));
	}
	
	public function onLoadComplete(evt : LibEvent) : Void
	{	
		setBackground(0xffffff, 10);
		setTitle();
		
		var tClose : MovieClip = view.attachMovie("c", "c", 210);
			tClose._x = view._width - 33;
			tClose._y = -17;
			tClose.onRelease = Delegate.create(this, close);
			
		centerize();
	}
	
	public function onTimeOut(evt : LibEvent) : Void
	{
		trace("ERROR: Photo loading time out: "+evt.getName());
	}
	
	private function photo_changed_event(evt : PhotoChangedEvent) : Void
	{
		if(evt.id == id)
		{
			if(!loaded) load();
			
			title = evt.title;
			show();
			protect();
		} else
		{
			if(isVisible())	hide();
		}
	}
	
	private function resize_event(evt : ResizeEvent) : Void
	{
		centerize();
	}
}
