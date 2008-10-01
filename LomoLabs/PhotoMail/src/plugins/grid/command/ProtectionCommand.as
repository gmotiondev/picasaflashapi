/**
 * @author michal.gron@gmail.com
 */

import com.bourre.ioc.control.AbstractCommand;

import plugins.grid.control.ProtectionEvent;
import plugins.grid.model.*;

class plugins.grid.command.ProtectionCommand extends AbstractCommand
{
	private var __model:GridModel;
	
	public function execute(evt:ProtectionEvent)
	{
		__model = GridModel(getModelLocator().getModel(ModelList.GRID_MODEL));
		__model.notifyChanged(evt);
	}
}