/**
 * @author michal.gron@gmail.com
 */

import com.bourre.ioc.visual.AbstractMovieClipHelper;
import com.bourre.ioc.plugin.IPlugin;
import com.bourre.ioc.plugin.BasicPluginEvent;

import plugins.grid.view.*;
import plugins.grid.view.dialog.*;

class plugins.grid.view.PhotosHolder extends AbstractMovieClipHelper
{
	private var __send_dialog:SendDialog;
	
	public function PhotosHolder(owner:IPlugin, name:String, mc:MovieClip)
	{
		super(owner, name, mc);
		initialize();
	}
	
	private function initialize():Void
	{
		__send_dialog = new SendDialog(getOwner(), "__send_dialog", view.createEmptyMovieClip("send_dialog_holder",2));
		__send_dialog.hide();
		
		addListener(__send_dialog);
	}
		
	public function addChild(aId:String, aUrl:String, aSummary:String):Void
	{	
		var tHolder:MovieClip = view.createEmptyMovieClip("photo_holder_"+aId, view.getNextHighestDepth());
		var tPhoto:Photo = new Photo(getOwner(), aId, tHolder, true, aUrl, aSummary)
			
		addListener(tPhoto);
		__send_dialog.addListener(tPhoto);
	}
		
	// listen to the model and dispatch to children
	public function handleEvent(evt:BasicPluginEvent):Void
	{
		notifyChanged(evt);
	}
}