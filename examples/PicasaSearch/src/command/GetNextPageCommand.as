/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.commands.Command;
import com.bourre.core.Model;

import model.*;
import control.GetNextPageEvent;

class command.GetNextPageCommand implements Command
{
	private var model:ModelApplication; 
	
	public function execute(event:GetNextPageEvent):Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		model.setNextPage();
		model.notifyChanged(event);
	}
}