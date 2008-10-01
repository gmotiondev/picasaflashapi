import com.bourre.events.BasicEvent;

import control.Controller;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class control.thumb.LoadThumbsEvent extends BasicEvent
{
	public var totalResults : Number;
	public var startIndex : Number;
	public var itemsPerPage : Number;

	public function LoadThumbsEvent(aTotalResults : Number, aStartIndex : Number, aItemsPerPage : Number)
	{
		super(Controller.LOAD_THUMBS_EVENT);
		
		totalResults = aTotalResults;
		startIndex = aStartIndex;
		itemsPerPage = aItemsPerPage;
	}
}