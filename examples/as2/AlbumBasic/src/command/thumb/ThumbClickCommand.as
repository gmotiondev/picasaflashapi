import com.bourre.commands.Command;
import com.bourre.core.Model;

import model.*;
import control.thumb.ThumbClickEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class command.thumb.ThumbClickCommand implements Command
{
	private var model : ModelApplication; 
	
	public function execute(evt : ThumbClickEvent) : Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		model.click(evt.id);
	}
}