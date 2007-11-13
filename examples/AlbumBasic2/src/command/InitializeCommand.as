/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.commands.Command;
import com.bourre.events.IEvent;
import com.bourre.core.Model;

import model.*;

class command.InitializeCommand implements Command
{
	private var __model:ModelApplication = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION)); 
	
	public function execute(e:IEvent):Void
	{
		trace("InitializeCommand");
		
	}
	
}