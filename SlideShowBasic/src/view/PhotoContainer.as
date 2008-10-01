import com.bourre.visual.MovieClipHelper;
import com.bourre.transitions.TweenMS;

import control.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class view.PhotoContainer extends MovieClipHelper
{
	public var container:MovieClip;
	public var id:String;

	public function PhotoContainer(aID:String, aContainer:MovieClip, aHide:Boolean)
	{
		super(aID, aContainer);
		
		id = aID;
		container = aContainer;
	
		setVisible(!aHide);
	}
	
	// listen to the model
	public function photo_changed_event(e:PhotoChangedEvent):Void
	{
		var t:TweenMS = null;
		
		if(PhotoChangedEvent(e).id == id)
		{	
			t = new TweenMS(view, '_alpha', 100, 500, 0);	
			show();
		} else
		{
			if(isVisible())
			{
				t = new TweenMS(view, '_alpha', 0, 500, 100);
				t.addEventListener(TweenMS.onMotionFinishedEVENT, this, hide);
			}
		}
		
		t.start();
	}
}
