import com.bourre.commands.Command;
import com.bourre.core.Model;

import control.page.GetPrevPageEvent;

import model.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class command.page.GetPrevPageCommand implements Command
{
	private var model : ModelApplication; 

	public function execute(evt : GetPrevPageEvent) : Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		model.setPrevPage();
		model.notifyChanged(evt);
	}
}