/**
 * @author michal.gron@gmail.com
 */

import com.bourre.ioc.control.AbstractCommand;

import plugins.grid.control.PhotoClickEvent;
import plugins.grid.model.*;

class plugins.grid.command.PhotoClickCommand extends AbstractCommand
{
	private var __model:GridModel;
	
	public function execute(evt:PhotoClickEvent)
	{
		__model = GridModel(getModelLocator().getModel(ModelList.GRID_MODEL));
		__model.click(evt.id);
	}
}