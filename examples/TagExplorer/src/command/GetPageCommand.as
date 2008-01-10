/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.commands.Command;
import com.bourre.core.Model;
import com.bourre.visual.MovieClipHelper;

import model.*;
import control.GetPageEvent;
import view.ViewList;

class command.GetPageCommand implements Command
{
	private var model:ModelApplication; 
	
	public function execute(event:GetPageEvent):Void
	{
		trace("GetPageCommand("+event.page_number+")");
		
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		model.setPage(event.page_number);
		model.notifyChanged(event);
	}
}