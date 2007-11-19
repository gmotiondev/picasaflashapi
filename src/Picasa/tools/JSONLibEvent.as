/**
 * Deprecated, will be deleted
 */
 import com.bourre.data.libs.LibEvent;
import com.bourre.events.EventType;
import com.bourre.log.PixlibStringifier;
	
import Picasa.tools.JSONLib;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 * 
 */

class Picasa.tools.JSONLibEvent	extends LibEvent
{
	public function JSONLibEvent(e:EventType, oLib:JSONLib)
	{
		super(e, oLib);
	}
	
	public function getLib():JSONLib
	{
		return JSONLib(super.getLib());
	}

	public function getData() : String
	{
		return getLib().getData();
	}

	public function toString() : String 
	{
		return PixlibStringifier.stringify(this);
	}
}