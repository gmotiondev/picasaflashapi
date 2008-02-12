/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.plugin.AbstractPlugin;
import com.bourre.events.IEvent;
import com.bourre.events.EventType;
import com.bourre.events.BasicEvent;

import plugins.grid.control.*;
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
		trace("grid up and running! channel-callback: "+aChannelCallback);
		
		Controller.getInstance(this).initialize();

		var view_t:ThumbsHolder = new ThumbsHolder(this, ViewList.THUMBS_HOLDER, __holder.createEmptyMovieClip(ViewList.THUMBS_HOLDER,5));
		var view_p:PhotosHolder = new PhotosHolder(this, ViewList.PHOTOS_HOLDER, __holder.createEmptyMovieClip(ViewList.PHOTOS_HOLDER,10));
		//var view_n:Navigation = new Navigation(ViewList.NAVIGATION,mc.createEmptyMovieClip(ViewList.NAVIGATION,20));
		
		
		var tModel:GridModel = new GridModel(this, ModelList.GRID_MODEL);
			tModel.addListener(view_t);
			tModel.addListener(view_p);
			tModel.initialize();
		
		var tEvt:IEvent = new BasicEvent(new EventType("getPhotosEvent"), {
			callback:getChannel(),
			user:aUser,
			album:aAlbum
			});

		fireExternalEvent(tEvt,aChannelCallback);
	}
	
	public function onGetPhotosEvent(evt:IEvent)
	{
		firePrivateEvent(new ShowPhotosEvent(evt.getTarget()));
		
	}
}