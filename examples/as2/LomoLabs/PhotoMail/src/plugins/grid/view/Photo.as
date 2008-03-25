/**
 * @author michal.gron@gmail.com
 */

import com.bourre.ioc.visual.AbstractMovieClipHelper;
import com.bourre.ioc.plugin.IPlugin;
import com.bourre.events.NumberEvent;
import com.bourre.events.EventType;
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.ILibListener;
import com.bourre.data.libs.LibStack;
import com.bourre.data.libs.GraphicLib;
import com.bourre.commands.Delegate;
import com.bourre.utils.Geom;
import com.bourre.transitions.MultiTweenMS;
import com.bourre.transitions.TweenMS;

import plugins.grid.control.*;
import plugins.grid.control.dialog.*;

class plugins.grid.view.Photo extends AbstractMovieClipHelper implements ILibListener
{	
	public var id:String;
	public var url:String;
	public var summary:String;
	
	private var background:MovieClip;
	private var loaded:Boolean = false;
	private var __dialog_visible:Boolean = false;
	
	public function Photo(owner:IPlugin, name:String, mc:MovieClip, aHide:Boolean, aUrl:String, aSummary:String)
	{
		super(owner, "p_"+name, mc);
		
		id = name;
		url = aUrl;
		summary = aSummary;	
		setVisible(!aHide);
	}

	public function setBackground(aColor:Number, aHighlight:Number, aMargin:Number):Void
	{
		var tTopbar:Number = 15;
		var tBottombar:Number = 30;
		
		background = Geom.buildRectangle(view, 4, (view._width+(2*aMargin)), (view._height+(2*aMargin) + tTopbar + tBottombar),aColor,aColor);
		background._x = -aMargin;
		background._y = -aMargin - tTopbar;
		background.__c = aColor;
		background.__h = aHighlight;
	}
	
	public function setTitle():Void
	{		
		var tTF:TextFormat = new TextFormat();
			tTF.font = "kroeger";
			tTF.size = 8;
			tTF.color = 0xd40073;
			
		view.createTextField("title_tf", 15, 0, -20, 320, 20);
		var tF:TextField = view.title_tf;
			tF.embedFonts = true;
			tF.html = true;
			tF.htmlText = summary;
			tF.setTextFormat(tTF);
	}
	
	private function close():Void
	{
		getOwner().firePrivateEvent(new PhotoClosedEvent());
	}
	
	private function send():Void
	{
		getOwner().firePrivateEvent(new GetSendDialogEvent(getOwner(), id));
	}
	
	private function load():Void
	{
		var tLibStack:LibStack = new LibStack();
			tLibStack.enqueue(new GraphicLib(view, 5), "gl_"+id, url);
			tLibStack.addListener(this);
			tLibStack.execute();
	}
	
	private function protect():Void
	{
		getOwner().firePrivateEvent(new ProtectionEvent(getOwner(), true));
	}
	
	private function unprotect():Void
	{
		getOwner().firePrivateEvent(new ProtectionEvent(getOwner(), false));
	}
	
	private function centerize():Void
	{
		var t:MultiTweenMS;
		
		if(!__dialog_visible)
		{
			t = new MultiTweenMS(view, ["_x", "_y"],
								[Math.round((Stage.width - view._width)/2 ) + 10, Math.round((Stage.height - view._height)/2) + 30],
								500, null, com.robertpenner.easing.Quad.easeOut);
		} else {
			t = new MultiTweenMS(view, ["_x", "_y"],
								[Math.round(Stage.width/2 - view._width) + 10, Math.round((Stage.height - view._height)/2) + 30],
								500, null, com.robertpenner.easing.Quad.easeOut);	
		}
		
		t.start();
	}
	
	private function fadeIn():Void
	{
		show();
		
		var t:TweenMS = new TweenMS(view, "_alpha", 100, 250, 0);
			t.start();
	}
	
	private function fadeOut():Void
	{
		//var t:TweenMS = new TweenMS(view, "_alpha", 0, 500, 100);
		//	t.addEventListener(TweenMS.onMotionFinishedEVENT, this, hide);
		//	t.start();
		hide();
	}
	
	public function onLoadInit(e:LibEvent):Void
	{	
		loaded = true;
	}
	
	public function onLoadProgress(e:LibEvent):Void
	{
		getOwner().firePublicEvent(new NumberEvent(new EventType("onProgress"), e.getPerCent()));
	}
	
	public function onLoadComplete(e:LibEvent):Void
	{	
		if(!loaded)
		{
			// photo isn't loaded, display refresh button!
			return;
		}
		
		setBackground(0xffffff, 0xffffff, 10);
		setTitle();
		
		var tClose = view.attachMovie("c", "c", 210); 
			tClose._x = view._width - 33;
			tClose._y = -17;
			tClose.onRelease = Delegate.create(this, close);

		var tSend = view.attachMovie("f", "f", 212);
			tSend._x = view._width - tSend._width - 23;
			tSend._y = view._height - 57;
			tSend.onRelease = Delegate.create(this, send);
			
		move(Math.round((Stage.width - view._width)/2)+10, Math.round((Stage.height - view._height)/2) + 30);
		centerize();
	}
	
	public function onTimeOut(e:LibEvent):Void
	{
		trace("ERROR: Photo loading time out: "+e.getName());
	}
	
	private function onSendDialogClosed():Void
	{
		__dialog_visible = false;
		centerize();
	}
	
	// listen to the model
	private function resize_event(evt:ResizeEvent):Void
	{
		centerize();
	}
	
	private function photo_changed_event(e:PhotoChangedEvent):Void
	{
		if(PhotoChangedEvent(e).id == id)
		{
			if(!loaded) load();
				
			fadeIn();
			protect();
		} else
		{
			if(isVisible())
			{
				fadeOut();
			}
		}
	}
	
	private function photo_closed_event(evt:PhotoClosedEvent):Void
	{
		fadeOut();
		unprotect();
	}
	
	private function get_send_dialog_event(evt:GetSendDialogEvent):Void
	{
		__dialog_visible = true; 
		
		centerize();
	}
	
	private function get_sending_dialog_event(evt:GetSendingDialogEvent):Void
	{
	}
	
	private function get_sent_dialog_event(evt:GetSentDialogEvent):Void
	{
	}
}