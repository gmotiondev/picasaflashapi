/**
 *
 */
import com.bourre.events.BasicEvent;

import control.Controller;

class control.SetPhotosEvent extends BasicEvent
{	
	public var totalResults:Number;
	public var itemsPerPage:Number;
	
	public function SetPhotosEvent(aTotalResults:Number, aItemsPerPage:Number)
	{
		super(Controller.SET_PHOTOS_EVENT);
		
		totalResults = aTotalResults;
		itemsPerPage = aItemsPerPage;
	}
}