/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.control.AbstractCommand;

import plugins.grid.control.PhotoGetNextEvent;
import plugins.grid.model.*;

class plugins.grid.command.PhotoGetNextCommand extends AbstractCommand
{
	private var __model:GridModel;
	
	public function execute(evt:PhotoGetNextEvent)
	{
		__model = GridModel(getModelLocator().getModel(ModelList.GRID_MODEL));
		__model.next();
	}
}