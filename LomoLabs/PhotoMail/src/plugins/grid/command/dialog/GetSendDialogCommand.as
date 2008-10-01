/**
 * @author michal.gron@gmail.com
 */
import com.bourre.ioc.control.AbstractCommand;

import plugins.grid.control.dialog.GetSendDialogEvent;
import plugins.grid.model.*;

class plugins.grid.command.dialog.GetSendDialogCommand extends AbstractCommand
{	
	private var __model:GridModel;
	
	public function execute(evt:GetSendDialogEvent)
	{
		__model = GridModel(getModelLocator().getModel(ModelList.GRID_MODEL));
		__model.notifyChanged(evt);
	}
}