/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.commands.Command;
import com.bourre.core.Model;

import model.*;
import control.GetPageEvent;

class command.GetPageCommand implements Command
{
	private var model:ModelApplication; 
	
	public function execute(event:GetPageEvent):Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		var tDirection:String = event.direction;
		
		switch(tDirection)
		{
			case "next": trace("next page!");
				model.nextPage();
				break;
			case "prev": trace("prev page!");
				model.prevPage();
				break;
		}
	}
}