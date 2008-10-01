import com.bourre.commands.Command;
import com.bourre.core.Model;

import model.*;
import control.page.GetNextPageEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class command.page.GetNextPageCommand implements Command
{
	private var model:ModelApplication; 
	
	public function execute(evt : GetNextPageEvent) : Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		model.setNextPage();
		model.notifyChanged(evt);
	}
}