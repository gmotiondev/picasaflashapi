/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import be.netdust.visual.assembler.ViewBuilder
import be.netdust.visual.containers.*;
import be.netdust.visual.object.*;

import com.bourre.events.EventType;
import com.bourre.events.EventBroadcaster;
import com.bourre.visual.MovieClipHelper;

import control.*;

class view.dialog.ConfirmDialog extends MovieClipHelper
{
	private var __vb:ViewBuilder;
	
	// just to get the classes included!
	private var __app:ApplicationView;
	private var __panel:Panel;
	private var __textbox:TextBox;
	private var __vbox:VBox;
	private var __hbox:HBox;
	private var __button:Button;
	// 
	
	public function ConfirmDialog(aID:String, aContainer:MovieClip)
	{
		super(aID, aContainer);
	}
	
	private function centerize():Void
	{
		move(Math.round((Stage.width - view._width)/2), Math.round((Stage.height - view._height)/2));
	}
	
	public function onResize(evt:ScreenResizeEvent):Void
	{
		centerize();
	}
	
	public function confirm_event():Void
	{
	}
}