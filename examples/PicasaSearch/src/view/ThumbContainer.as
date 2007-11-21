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
		
		// setBackground(0xffffff, 0xe2007a, 4);
	}
	
	private function setBackground(aColor:Number, aHighlight:Number, aMargin:Number):Void
	{
		__b = Geom.buildRectangle(view,2,(10+(2*aMargin)),(10+(2*aMargin)),aColor,aColor);
		__b._x = -aMargin;
		__b._y = -aMargin;
		__b.__c = aColor;
		__b.__h = aHighlight;
	}
}
