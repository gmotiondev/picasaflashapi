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
	private var __def_label : String = "Search picasaweb";
	private var __def_query : String = "Type to search";
	private var __vb : ViewBuilder;
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
				'		<Panel id="dialog_panel" label="' + __def_label + '">' + 
				'			<VBox>' + 
				'				<HBox>' + 
				'					<TextBox id="query" label="' + __def_query + '" width="300"/>' + 
				'					<Button id="button_submit" label="Search"/>' + 
				'				</HBox>' + 
				'				<Label id="status" labe=" "/>' + 
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
		
		var tSendButton : Button = __vb.getChildByID("button_submit");
			tSendButton.addEventListener(new EventType("onClick"), this);
			
		centerize();
	}

	public function getQuery() : String
	{
		return __vb.getChildByID("query").getText();
	}

	public function setSearchStatus(aStatus : String) : Void
	{	
		var tL : Label = __vb.getChildByID("status");
			tL.setLabel(aStatus);
	}

	private function centerize() : Void
	{
		move(Math.round(Stage.width / 2 - view._width / 2), Math.round(Stage.height / 2 - view._height / 2));
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
		setSearchStatus("Searching ...");
		
		EventBroadcaster.getInstance().broadcastEvent(new LoadFeedEvent(escape(getQuery())));
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
		var tRes : String = (evt.totalResults == 0) ? "None found" : "Found " + evt.totalResults + " photos (" + tFrom + " - " + tTo + ").";
		
		setSearchStatus(tRes);
	}

	public function get_next_page_event(evt : GetNextPageEvent) : Void
	{
		onClick();
	}

	public function get_prev_page_event(evt : GetPrevPageEvent) : Void
	{
		onClick();
	}
}