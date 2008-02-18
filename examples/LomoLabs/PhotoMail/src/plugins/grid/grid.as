/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.plugin.AbstractPlugin;
import com.bourre.events.IEvent;
import com.bourre.events.EventType;
import com.bourre.events.BasicEvent;

import plugins.grid.control.*;
import plugins.grid.control.dialog.*;
import plugins.grid.model.*;
import plugins.grid.view.*;

class plugins.grid.grid extends AbstractPlugin
{
	private var __holder:MovieClip;
	
	public function grid(mc:MovieClip)
	{
		super();
		
		__holder = mc;
	}
	
	private function initialize(aChannelCallback:String, aUser:String, aAlbum:String):Void
	{
		Stage.addListener(this);
		Key.addListener(this);
		
		Controller.getInstance(this).initialize();

		var view_t:ThumbsHolder = new ThumbsHolder(this, ViewList.THUMBS_HOLDER, __holder.createEmptyMovieClip(ViewList.THUMBS_HOLDER,5));
		var view_r:Protection = new Protection(this, ViewList.PROTECTION, __holder.createEmptyMovieClip(ViewList.PROTECTION,8));
		var view_p:PhotosHolder = new PhotosHolder(this, ViewList.PHOTOS_HOLDER, __holder.createEmptyMovieClip(ViewList.PHOTOS_HOLDER,10));
		var view_n:Navigation 	= new Navigation(this, ViewList.NAVIGATION, __holder.createEmptyMovieClip(ViewList.NAVIGATION,15));
		
		var tModel:GridModel = new GridModel(this, ModelList.GRID_MODEL);
			tModel.addListener(view_t);
			tModel.addListener(view_r);
			tModel.addListener(view_p);
			tModel.addListener(view_n);
		
		var tEvt:IEvent = new BasicEvent(new EventType("getPhotosEvent"), {
			callback:getChannel(),
			user:aUser,
			album:aAlbum
			});

		fireExternalEvent(tEvt,aChannelCallback);
	}
	
	public function onGetPhotosEvent(evt:IEvent)
	{
		firePrivateEvent(new InitializeEvent(this, evt.getTarget()));
	}
	
	public function onPhotoSent(evt:BasicEvent):Void
	{
		var tMessage:String = evt.getTarget().message;
		var tId:String = evt.getTarget().id;
		
		firePrivateEvent(new GetSentDialogEvent(this, tId, tMessage));
	}
	
	public function onResize():Void
	{
		firePrivateEvent(new ResizeEvent(this));
	}
	
	public function onKeyDown():Void
	{
		switch (Key.getCode())
		{
			case Key.RIGHT: firePrivateEvent(new PhotoGetNextEvent(this)); break ;
			case Key.LEFT: 	firePrivateEvent(new PhotoGetPreviousEvent(this)); break ;
		}	
	}
}