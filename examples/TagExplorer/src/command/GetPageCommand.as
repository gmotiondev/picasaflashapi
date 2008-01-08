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
		model.setPage(event.page_number)
	}
}