/**
 * @author michal.gron@gmail.com
 */

import com.bourre.ioc.visual.AbstractMovieClipHelper;
import com.bourre.ioc.plugin.IPlugin;

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
		__send_dialog = new SendDialog(getOwner(), "__send_dialog", view.createEmptyMovieClip("send_dialog_holder",view.getNextHighestDepth()));
		__send_dialog.hide();
		
		addListener(__send_dialog);
	}
	
	public function addChild(aId:String, aUrl:String, aSummary:String):Void
	{
		var tHolder:MovieClip = view.createEmptyMovieClip("photo_holder_"+aId, view.getNextHighestDepth());
		var tPhoto:Photo = new Photo(getOwner(), aId, tHolder, true, aUrl, aSummary)
			
		addListener(tPhoto);
	}
	
	// listen to the model and dispatch to children
	public function get_send_dialog_event(evt:GetSendDialogEvent):Void
	{
		if(view.send_dialog_holder.getDepth()< (view.getNextHighestDepth() - 1))
		{
			view.send_dialog_holder.swapDepths(view.getNextHighestDepth());
		}
		
		__send_dialog.setDialog("send");
		__send_dialog.move(330, 20);
	}
	
	public function get_sending_dialog_event(evt:GetSendingDialogEvent):Void
	{
		__send_dialog.setDialog("sending");
		__send_dialog.move(330, 20);
	}
	
	public function get_sent_dialog_event(evt:GetSentDialogEvent):Void
	{
		__send_dialog.setDialog("sent");
		__send_dialog.setResult(evt.message);
		__send_dialog.move(330, 20);
	}
	
	public function resize_event(evt:ResizeEvent):Void
	{
		notifyChanged(evt);
	}
	
	public function photo_changed_event(evt:PhotoChangedEvent):Void
	{
		notifyChanged(evt);
	}
}