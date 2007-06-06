import com.bourre.commands.Command;
import com.bourre.events.IEvent;
import com.bourre.log.PixlibStringifier;

import models.ModelApplication;
import uis.PhotoHolder;
import uis.Navigation;
import uis.uilist;

/**
  @author Michal Gron (michal.gron@gmail.com)
 */
class controllers.RunApplication implements Command
{	
	public function execute(e:IEvent):Void 
	{
		var tC = e.getTarget();
		
		var tPH:PhotoHolder = new PhotoHolder(uilist.PHOTO,tC.createEmptyMovieClip("photoholder",10));
		var tNAV:Navigation = new Navigation(uilist.NAVIGATION,tC.createEmptyMovieClip("navigation",20));
		
		var model:ModelApplication = new ModelApplication();
			model.setContainer(tC);
			model.initialize();	
	}
	
	public function toString():String
	{
		return PixlibStringifier.stringify(this);
	}
	
}
