﻿/**
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

import plugins.grid.control.*;
import plugins.grid.control.dialog.*;

class plugins.grid.view.Photo extends AbstractMovieClipHelper implements ILibListener
{	
	public var id:String;
	public var url:String;
	public var summary:String;
	
	private var background:MovieClip;
	private var loaded:Boolean = false;
	
	
	public function Photo(owner:IPlugin, name:String, mc:MovieClip, aHide:Boolean, aUrl:String, aSummary:String)
	{
		super(owner, "p_"+name, mc);
		
		id = name;
		url = aUrl;
		summary = aSummary;	
		setVisible(!aHide);
	}

	private function setBackground(aColor:Number, aHighlight:Number, aMargin:Number):Void
	{
		var tTopbar:Number = 15;
		var tBottombar:Number = 30;
		
		background = Geom.buildRectangle(view, 4, (view._width+(2*aMargin)), (view._height+(2*aMargin) + tTopbar + tBottombar),aColor,aColor);
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
			tF.htmlText = summary;
			tF.setTextFormat(tTF);
	}
	
	private function close():Void
	{
		hide();
		unprotect();
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
		var t:MultiTweenMS = new MultiTweenMS(	view,	["_x", "_y"],
												[Math.round(Stage.width/2 - view._width/2 + 10), Math.round(Stage.height/2 - view._height/2)],
												500, null, com.robertpenner.easing.Quad.easeOut);
			t.start();
	}
	
	public function onLoadInit(e:LibEvent):Void
	{	
	}
	
	public function onLoadProgress(e:LibEvent):Void
	{
		getOwner().firePublicEvent(new NumberEvent(new EventType("onProgress"), e.getPerCent()));
	}
	
	public function onLoadComplete(e:LibEvent):Void
	{	
		loaded = true;
		
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
			
		centerize();
	}
	
	public function onTimeOut(e:LibEvent):Void
	{
		trace("ERROR: Photo loading time out: "+e.getName());
	}
	
	// listen to the model
	public function resize_event(evt:ResizeEvent):Void
	{
		centerize();
	}
	
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