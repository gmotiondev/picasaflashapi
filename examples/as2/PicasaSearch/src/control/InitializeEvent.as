/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;
import control.Controller;

class control.InitializeEvent extends BasicEvent
{
	public var totalResults:Number;
	public var startIndex:Number;
	public var itemsPerPage:Number;
	
	public function InitializeEvent(aTotalResults:Number, aStartIndex:Number, aItemsPerPage:Number)
	{
		super(Controller.INITIALIZE_EVENT);
		
		totalResults = aTotalResults;
		startIndex = aStartIndex;
		itemsPerPage = aItemsPerPage;
	}
}