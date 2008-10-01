/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.BasicEvent;
import control.Controller;

class control.GetPhotosEvent extends BasicEvent
{
	public var tag:String;
	public var hasChanged:Boolean = true;
	public function GetPhotosEvent(aTag:String, aHasChanged:Boolean)
	{
		super(Controller.GET_PHOTOS_EVENT);
		
		tag = aTag;
		hasChanged = aHasChanged;
	}
}