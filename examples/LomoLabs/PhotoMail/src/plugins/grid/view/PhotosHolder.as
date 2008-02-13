/**
 * @author michal.gron@gmail.com
 */

import com.bourre.ioc.visual.AbstractMovieClipHelper;
import com.bourre.ioc.plugin.IPlugin;

import plugins.grid.view.Photo;
import plugins.grid.control.PhotoChangedEvent;
import plugins.grid.control.ResizeEvent;

class plugins.grid.view.PhotosHolder extends AbstractMovieClipHelper
{
	public function PhotosHolder(owner:IPlugin, name:String, mc:MovieClip)
	{
		super(owner, name, mc);
	}
	
	public function addChild(aId:String, aUrl:String, aSummary:String):Void
	{
		var tHolder:MovieClip = view.createEmptyMovieClip("photo_holder_"+aId, view.getNextHighestDepth());
		var tPhoto:Photo = new Photo(getOwner(), aId, tHolder, true, aUrl, aSummary)
			
		addListener(tPhoto);
	}
	
	// listen to the model and dispatch to children
	public function photo_changed_event(evt:PhotoChangedEvent):Void
	{
		notifyChanged(evt);
	}
	
	public function resize_event(evt:ResizeEvent):Void
	{
		notifyChanged(evt);
	}
}