/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import be.netdust.visual.containers.*;
import be.netdust.visual.object.*;
import be.netdust.visual.data.DataProvider;

import com.bourre.events.IEvent;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.EventType;

import control.GetPhotosEvent;

class view.dialog.PageDialog extends Panel
{	
	private var __total_results:Number;
	private var __per_page_results:Number;
	
	public function PageDialog(aHolder:MovieClip, aTotalResults:Number, aPerPageResults:Number)
	{
		super("Pages");

		__total_results = aTotalResults;
		__per_page_results = aPerPageResults;
		
		
		initialize(aHolder);
	}
	
	private function initialize(aHolder:MovieClip):Void
	{
		setUI(aHolder.createEmptyMovieClip("page_panel",3));
		setPosition(20, 380);

		// there is at least one page
		if((__total_results/__per_page_results) > 1)
		{
			var tPagesCount:Number = Math.ceil(__total_results/__per_page_results);
			trace("got to make "+tPagesCount+" pages!");
			
			var tHBox:HBox = new HBox();
			
			for(var a:Number = 1; a <= tPagesCount; a++)
			{
				var tPageButton:be.netdust.visual.object.Button = new be.netdust.visual.object.Button(""+a);
					tPageButton.addEventListener(new EventType("onClick"), this);
				tHBox.addChild(tPageButton);
			}
			
			addChild(tHBox);
			
			create();
				
		} else
		{
			// do nothing;
			return;
		}
	}
	
	private function onClick(event:IEvent):Void
	{
		trace("got onClick from "+event.getTarget());
		//EventBroadcaster.getInstance().broadcastEvent(new GetPhotosEvent(event.getTarget().currentItem.getValue()));
	}
}