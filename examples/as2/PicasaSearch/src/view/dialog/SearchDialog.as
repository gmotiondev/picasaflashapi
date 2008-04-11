import gs.TweenLite;

import com.bourre.commands.Delegate;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.EventType;
import com.bourre.visual.MovieClipHelper;

import be.netdust.visual.assembler.ViewBuilder;
import be.netdust.visual.containers.*;
import be.netdust.visual.object.*;

import control.*;
import control.page.GetNextPageEvent;
import control.page.GetPrevPageEvent;
import control.thumb.LoadThumbsEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class view.dialog.SearchDialog extends MovieClipHelper
{		
	private var __vb : ViewBuilder;
	private var __minimized : Boolean = false;
	
	// just to get the classes included!
	private var __app : ApplicationView;
	private var __panel : Panel;
	private var __textbox : TextBox;
	private var __label : Label;
	private var __vbox : VBox;
	private var __hbox : HBox;
	private var __button : Button;

	public function SearchDialog(aID : String, aContainer : MovieClip)
	{
		super(aID, aContainer);
		
		initialize();
	}

	private function initialize() : Void
	{
		Key.addListener(this);
		
		var tXml : XML = new XML(
				'<?xml version="1.0"?>' + 
				'<beans>' + 
				'	<view id="main">' +
				'		<Button id="maximize" label="S" visible="false"/>' + 
				'		<Panel id="dialog_panel" label="Search picasaweb">' + 
				'			<VBox>' + 
				'				<HBox>' + 
				'					<TextBox id="query" label="Type to search" width="300"/>' + 
				'					<Button id="button_submit" label="Search"/>' + 
				'				</HBox>' + 
				'				<Label id="status" label=" "/>' + 
				' 			</VBox>' + 
				'		</Panel>' + 
				'	</view>' + 
				'</beans>');
			
		__vb = new ViewBuilder();
		__vb.addListener(this);
		__vb.parseExternal(tXml);
	}

	private function onViewInit() : Void
	{
		__vb.register(view);
		
		var tSend : Button = __vb.getChildByID("button_submit");
			tSend.addEventListener(new EventType("onClick"), this);
			
		var tMax : Button = __vb.getChildByID("maximize");
			tMax.addEventListener(new EventType("onClick"), Delegate.create(this, maximize));
			tMax.getUI()._visible = false;
			
		centerize();
	}

	private function getQuery() : String
	{
		return __vb.getChildByID("query").getText();
	}

	private function setSearchStatus(aStatus : String) : Void
	{	
		var tL : Label = __vb.getChildByID("status");
			tL.setLabel(aStatus);
	}

	private function centerize() : Void
	{
		var tX : Number = __minimized ? 0 : Math.round((Stage.width - view._width) / 2);
		var tY : Number = __minimized ? 0 : Math.round((Stage.height - view._height) / 2);
		
		TweenLite.to(view, 0.5,{_x : tX, _y : tY});
	}

	private function minimize() : Void
	{
		switchDialog(false);
	}
	
	private function maximize() : Void
	{
		switchDialog(true);
	}

	private function switchDialog(aShow : Boolean) : Void
	{
		__minimized = !aShow;
		
		var tPanel : Panel = __vb.getChildByID("dialog_panel");
			tPanel.getUI()._visible = aShow;
		var tMaximizeButton : Button = __vb.getChildByID("maximize");
			tMaximizeButton.getUI()._visible = !aShow;
			
		centerize();
	}

	private function onKeyDown() : Void
	{	
		if(Key.isDown(Key.ENTER)) 
		{
			onClick();
		}
	}

	private function onClick() : Void
	{
		var tQuery : String = escape(getQuery());
		
		if(tQuery != "")
		{
			setSearchStatus("Searching ...");
			EventBroadcaster.getInstance().broadcastEvent(new LoadFeedEvent(tQuery));
		} else
		{
			minimize();
		}
	}

	// listen to the model.
	public function onResize(evt : ResizeEvent) : Void
	{
		centerize();
	}

	public function load_thumbs_event(evt : LoadThumbsEvent) : Void
	{
		var tFrom : Number = evt.startIndex;
		var tTo : Number = ((evt.startIndex + evt.itemsPerPage) > evt.totalResults ? evt.totalResults : (evt.itemsPerPage + evt.startIndex));		
		var tRes : String = (evt.totalResults == 0) ? "None found" : "Found " + evt.totalResults + " photos (showing " + tFrom + " - " + tTo + ").";
		
		setSearchStatus(tRes);
		minimize();
	}

	public function get_next_page_event(evt : GetNextPageEvent) : Void
	{
		onClick();
	}

	public function get_prev_page_event(evt : GetPrevPageEvent) : Void
	{
		onClick();
	}
	
	public function onError(evt : ErrorEvent) : Void
	{
		maximize();
		setSearchStatus(evt.message);
	}
}