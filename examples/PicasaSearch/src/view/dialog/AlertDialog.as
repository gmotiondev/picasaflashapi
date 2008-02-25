/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import be.netdust.visual.assembler.ViewBuilder
import be.netdust.visual.containers.*;
import be.netdust.visual.object.*;

import com.bourre.events.EventType;
import com.bourre.visual.MovieClipHelper;

import control.*;

class view.dialog.AlertDialog extends MovieClipHelper
{
	private var __vb:ViewBuilder;
	
	// just to get the classes included!
	private var __app:ApplicationView;
	private var __panel:Panel;
	private var __label:Label;
	private var __vbox:VBox;
	private var __button:Button;
	// 
	
	public function AlertDialog(aID:String, aContainer:MovieClip)
	{
		super(aID, aContainer);
		
		initialize();
	}
	
	private function initialize():Void
	{
		var tXml:XML = new XML('<?xml version="1.0"?>'+
			'<beans>' +
			'	<view id="main_alert">' +
			'		<Panel id="alert_panel" label="Alert">' +
			'			<VBox>' +
			'				<Label id="query" label="this is some alert box" width="200" height="100"/>' +
			'				<Button id="button_close" label="Close"/>' +
			' 			</VBox>' +
			'		</Panel>' +
			'	</view>' +
			'</beans>');
			
		__vb = new ViewBuilder();
		__vb.addListener(this)
		__vb.parseExternal(tXml);
		
		hide();
	}
	
	private function onViewInit():Void
	{
		__vb.register(view);
		
		var tB:Button = __vb.getChildByID("button_close");
			tB.addEventListener(new EventType("onClick"), this);
			
		centerize();
	}
	
	private function centerize():Void
	{
		move(Math.round((Stage.width - view._width)/2), Math.round((Stage.height - view._height)/2));
	}
	
	private function onClick():Void
	{
		hide();
		trace("closing ...");
	}
	
	public function onResize(evt:ScreenResizeEvent):Void
	{
		centerize();
	}
	
	public function timeout_event():Void
	{
		show();
	}
	
	public function error_event():Void
	{
		show();
	}
}