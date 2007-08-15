import com.bourre.commands.Command;
import com.bourre.events.IEvent;
import com.bourre.log.PixlibStringifier;
import com.bourre.visual.MovieClipHelper;

import view.LoadingBar;
import view.ViewList;

/**
  @author Michal Gron (michal.gron@gmail.com)
 */
class commands.OnSetLoaderProgress implements Command
{	
	public function execute(e:IEvent):Void 
	{
		var tP:Number = e.getTarget();
		var tLB:LoadingBar = LoadingBar(MovieClipHelper.getMovieClipHelper(ViewList.LOADING_BAR));
		
		switch(tP)
		{
			case 0: 	tLB.show(); break;
			case 100: 	tLB.hide(); break;
			default: 	tLB.show(); break;
		}
		
		tLB.setProgress(tP);
	}
	
	public function toString():String
	{
		return PixlibStringifier.stringify(this);
	}
	
}
