/**
 * @author michal.gron@gmail.com
 */

import com.bourre.ioc.visual.AbstractMovieClipHelper;
import com.bourre.ioc.plugin.IPlugin;
import com.bourre.transitions.MultiTweenMS;

import plugins.grid.view.*;
import plugins.grid.view.dialog.*;
import plugins.grid.control.*;
import plugins.grid.control.dialog.*;

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
	public function get_send_dialog_event(evt:GetSendDialogEvent):Void
	{		
		__send_dialog.setDialog("send");
		
		notifyChanged(evt);
	}
	
	public function get_sending_dialog_event(evt:GetSendingDialogEvent):Void
	{
		__send_dialog.setDialog("sending");
		
		notifyChanged(evt);
	}
	
	public function get_sent_dialog_event(evt:GetSentDialogEvent):Void
	{
		__send_dialog.setDialog("sent");
		__send_dialog.setResult(evt.message);
		
		notifyChanged(evt);
	}
	
	public function resize_event(evt:ResizeEvent):Void
	{
		notifyChanged(evt);
	}
	
	public function photo_changed_event(evt:PhotoChangedEvent):Void
	{
		notifyChanged(evt);
	}
	
	public function photo_closed_event(evt:PhotoClosedEvent):Void
	{
		notifyChanged(evt);
	}
}