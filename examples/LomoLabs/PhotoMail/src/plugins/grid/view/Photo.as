/**
 * @author michal.gron@gmail.com
 */

import com.bourre.ioc.visual.AbstractMovieClipHelper;
import com.bourre.ioc.visual.ScreenProtection;
import com.bourre.ioc.plugin.IPlugin;

import com.bourre.events.NumberEvent;
import com.bourre.events.EventType;
import com.bourre.visual.MovieClipHelper; 
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.ILibListener;
import com.bourre.data.libs.LibStack;
import com.bourre.data.libs.GraphicLib;
import com.bourre.commands.Delegate;
import com.bourre.utils.Geom;

import plugins.grid.control.PhotoChangedEvent;

class plugins.grid.view.Photo extends AbstractMovieClipHelper implements ILibListener
{	
	public var id:String;
	public var url:String;
	public var title:String;
	
	private var background:MovieClip;
	private var loaded:Boolean = false;
	
	public function Photo(owner:IPlugin, name:String, mc:MovieClip, aHide:Boolean, aUrl:String, aTitle:String)
	{
		super(owner, "p_"+name, mc);
		
		id = name;
		url = aUrl;
		title = aTitle;	
		setVisible(!aHide);
	}

	private function setBackground(aColor:Number, aHighlight:Number, aMargin:Number):Void
	{
		var tTopbar:Number = 15;
		background = Geom.buildRectangle(view, 4, (view._width+(2*aMargin)), (view._height+(2*aMargin) + tTopbar),aColor,aColor);
		background._x = -aMargin;
		background._y = -aMargin - tTopbar;
		background.__c = aColor;
		background.__h = aHighlight;
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
	
	private function close():Void
	{
		hide();
		unprotect();
	}
	
	private function load():Void
	{
		var tLibStack:LibStack = new LibStack();
			tLibStack.enqueue(new GraphicLib(view, 5), "gl_"+id, url);
			tLibStack.addListener(this);
			tLibStack.execute();
	}
	
	public function onLoadInit(e:LibEvent):Void
	{
		loaded = true;
	}
	
	public function onLoadProgress(e:LibEvent):Void
	{
		getOwner().firePublicEvent(new NumberEvent(new EventType("onProgress"),e.getPerCent()));
	}
	
	public function onLoadComplete(e:LibEvent):Void
	{	
		setBackground(0xffffff, 0xffffff, 10);
		setTitle();
		
		var tClose = view.attachMovie("c", "c", 210);
		var tClose_mc = 
			tClose._x = view._width - 33;
			tClose._y = -17;
			tClose.onRelease = Delegate.create(this, close);

		centerize();
	} 
	
	public function onTimeOut(e:LibEvent):Void
	{
		trace("ERROR: Photo loading time out: "+e.getName());
	}
	
	private function centerize():Void
	{
		move(Math.round(Stage.width/2 - view._width/2 + 10), Math.round(Stage.height/2 - view._height/2));
	}
	
	private function protect():Void
	{
	}
	
	private function unprotect():Void
	{
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
}