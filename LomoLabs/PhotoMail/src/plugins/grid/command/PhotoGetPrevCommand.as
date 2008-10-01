/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.control.AbstractCommand;

import plugins.grid.control.PhotoGetPreviousEvent;
import plugins.grid.model.*;

class plugins.grid.command.PhotoGetPrevCommand extends AbstractCommand
{
	private var __model:GridModel;
	
	public function execute(evt:PhotoGetPreviousEvent)
	{
		__model = GridModel(getModelLocator().getModel(ModelList.GRID_MODEL));
		__model.prev();
	}
}