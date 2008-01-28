/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.commands.Command;
import com.bourre.core.Model;

import model.*;
import control.GetPrevPageEvent;

class command.GetPrevPageCommand implements Command
{
	private var model:ModelApplication; 
	
	public function execute(event:GetPrevPageEvent):Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		model.setPrevPage();
		model.notifyChanged(event);
	}
}