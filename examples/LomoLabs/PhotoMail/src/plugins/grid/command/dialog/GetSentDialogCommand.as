/**
 * @author michal.gron@gmail.com
 */
import com.bourre.ioc.control.AbstractCommand;

import plugins.grid.control.dialog.GetSentDialogEvent;
import plugins.grid.model.*;

class plugins.grid.command.dialog.GetSentDialogCommand extends AbstractCommand
{	
	private var __model:GridModel;
	
	public function execute(evt:GetSentDialogEvent)
	{
		__model = GridModel(getModelLocator().getModel(ModelList.GRID_MODEL));
		__model.notifyChanged(evt);
	}
}