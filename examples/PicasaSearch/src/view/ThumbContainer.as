/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.EventBroadcaster;
import com.bourre.visual.MovieClipHelper;
import com.bourre.commands.Delegate;
import com.bourre.utils.Geom;

import control.*;

class view.ThumbContainer extends MovieClipHelper
{
	private var title:String;
	private var id:String;
	private var __b:MovieClip;
	
	public function ThumbContainer(aID:String, aContainer:MovieClip, aTitle:String)
	{
		super(aID, aContainer);
		
		id = aID;
		title = aTitle;
	}
}
